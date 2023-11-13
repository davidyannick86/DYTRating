// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public enum RatingImage: String {
    case star = "star"
    case heart = "heart"
    
    var fillImage: Image {
        Image(systemName: rawValue + ".fill")
    }
    
    var openImage: Image {
        Image(systemName: rawValue)
    }
}

public struct RatingView: View {
    
    @Binding var currentRating: Int?
    
    var maxRating: Int
    var ratingImage: RatingImage
    var showNumberText: Bool
    
    var textColor: Color
    
#if os(macOS)
    var color: NSColor
#elseif os(iOS)
    var color: UIColor
#endif
    
#if os(macOS)
    public init(
        currentRating: Binding<Int?>,
        maxRating: Int = 5,
        ratingImage: RatingImage = .star,
        color: NSColor = .systemYellow,
        showNumberText: Bool = false,
        textColor: Color = .white
    ) {
        self._currentRating = currentRating
        self.maxRating = maxRating
        self.ratingImage = ratingImage
        self.color = color
        self.showNumberText = showNumberText
        self.textColor = textColor
    }
#elseif os(iOS)
    public init(
        currentRating: Binding<Int?>,
        maxRating: Int = 5,
        ratingImage: RatingImage = .star,
        color: UIColor = .systemYellow,
        showNumberText: Bool = false,
        textColor: Color = .white
    ) {
        self._currentRating = currentRating
        self.maxRating = maxRating
        self.ratingImage = ratingImage
        self.color = color
        self.showNumberText = showNumberText
        self.textColor = textColor
    }
#endif
    
    func ratingimage(for rating: Int) -> Image {
        if rating < currentRating ?? 0 {
            return ratingImage.fillImage
        } else {
            return ratingImage.openImage
        }
    }
    
    public var body: some View {
        HStack {
            ForEach(0...maxRating, id:\.self) { index in
                ratingimage(for: index)
#if os(macOS)
                    .foregroundStyle(Color(nsColor: color))
#elseif os(iOS)
                    .foregroundStyle(Color(uiColor: color))
#endif
                    .onTapGesture {
                        self.currentRating = index + 1
                    }
            }
            if showNumberText {
                Spacer()
                Text("\(currentRating ?? 0)")
                    .foregroundStyle(textColor)
            }
        }
    }
}
