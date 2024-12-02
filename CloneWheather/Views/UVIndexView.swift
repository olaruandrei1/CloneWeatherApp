import SwiftUI

struct UVIndexView: View {
    @StateObject private var viewModel: UVIndexViewModel

    init(apiKey: String?) {
        _viewModel = StateObject(wrappedValue: UVIndexViewModel(apiKey: apiKey))
    }

    var body: some View {
        VStack(alignment: .leading) {
            (
                Text(Image(systemName: "sun.max.fill"))
                +
                Text("UV Index".uppercased())
            )
            .font(Font.system(size: 12))
            .fontWeight(.medium)
            .foregroundColor(Color.currentTheme.sectionHeaderColor)
            .shadow(radius: 1.0)
            
            if let uvIndex = viewModel.uvIndex {
                Text("\(uvIndex.index, specifier: "%.1f")")
                    .font(Font.system(size: 32))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                
                Text(viewModel.uvCategory)
                    .font(Font.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                ProgressView(value: viewModel.uvIndex?.index)
                    .progressViewStyle(ProgressViewComponentView(range: 0...1.0, foregroundColor: AnyShapeStyle(uvGradient), backgroundColor: .gray))
                    .frame(maxHeight: 5.0)
                    .padding(.vertical, 10)
                
                Text(viewModel.sunProtectionAdvice)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            } else if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.white)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(Font.system(size: 14))
                    .foregroundColor(.red)
            } else {
                Text("No UV data available.")
                    .font(Font.system(size: 14))
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(10.0)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
        .onAppear {
            viewModel.fetchUVIndex()
        }
    }
    
    var uvGradient: LinearGradient {
        return LinearGradient(colors:
                                [
                                    .green,
                                    .yellow,
                                    .orange,
                                    .red,
                                    .purple
                                ], startPoint: .leading, endPoint: .trailing)
    }
}

#Preview {
    ScrollView {
        HStack {
            UVIndexView(apiKey: SecretsHelper.Keys.API_KEY.rawValue)
                .aspectRatio(1.0, contentMode: .fill)
        }
    }
    .padding()
    .background(.blue)
}
