//
//  NewsDetailView.swift
//  SctAppTV
//
//  Created by Rohit.Dwivedi on 02/06/25.
//

import SwiftUI

struct NewsDetailView2: View {
    @Environment(\.dismiss) var dismiss
    @State private var scrollOffset: CGFloat = 0
    @State private var isScrolling = true

    let imageWidth: CGFloat = 6500
    let scrollSpeed: CGFloat = 1

    // Timer for auto-scrolling
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            HStack{
                Button {
                   dismiss()
                } label: {
                    Label("Back", systemImage: "arrowshape.backward.fill")
                }
                Spacer()
            }.frame(height: 50)
           // Spacer().frame(height:300)

            OffsetScrollView(offset: $scrollOffset) {
                HStack {
                    Image("space") // Replace with your image name
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame( height: imageWidth)
                }
            }
           // .frame(height: 300)
            .onReceive(timer) { _ in
                if isScrolling {
                    let maxOffset = imageWidth - UIScreen.main.bounds.width
                    if scrollOffset < maxOffset {
                        scrollOffset += scrollSpeed
                    } else {
                        scrollOffset = 0 // loop back to start
                    }
                }
            }
/*
            HStack(spacing: 20) {
                Button(action: {
                    isScrolling = false
                }) {
                    Label("Pause", systemImage: "pause.circle")
                        .font(.title2)
                }

                Button(action: {
                    isScrolling = true
                }) {
                    Label("Resume", systemImage: "play.circle")
                        .font(.title2)
                }
            }
            .padding(.top)*/
        }
        .padding()
    }
}

#Preview {
    NewsDetailView()
}



struct OffsetScrollView<Content: View>: UIViewRepresentable {
    var content: () -> Content
    @Binding var offset: CGFloat

    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self._offset = offset
        self.content = content
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.delegate = context.coordinator

        let hostedView = UIHostingController(rootView: content())
        hostedView.view.translatesAutoresizingMaskIntoConstraints = false
        hostedView.view.backgroundColor = .clear

        scrollView.addSubview(hostedView.view)

        NSLayoutConstraint.activate([
            hostedView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostedView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostedView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostedView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostedView.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: OffsetScrollView

        init(_ parent: OffsetScrollView) {
            self.parent = parent
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}



import SwiftUI
import Combine



struct NewsDetailView: View {
    @Environment(\.dismiss) var dismiss

    @State private var scrollOffset: CGFloat = 0
    @State private var isScrolling = true
    @State private var isScrollingDown = true
    @State private var isUserInteracting = false
    let imageWidth: CGFloat = 6500

    let scrollSpeed: CGFloat = 6
    let stepTime: TimeInterval = 0.05
    let contentHeight: CGFloat = 2550//6500//2000
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            HStack{
                Button {
                   dismiss()
                } label: {
                    Label("Back", systemImage: "arrowshape.backward.fill")
                }
                Spacer()
            }.frame(height: 50)
                .padding(.bottom,20)
            VerticalOffsetScrollView(offset: $scrollOffset, isUserInteracting: $isUserInteracting) {
                VStack() {
                        Image("news1") // Replace with your image name
                            //.resizable()
                            //.aspectRatio(contentMode: .fill)
                           // .frame( height: imageWidth)
                }
            } //.frame(height: UIScreen.main.bounds.height - 200)
           // .frame(height: 400)
            .onReceive(timer) { _ in
                guard isScrolling, !isUserInteracting else { return }

                withAnimation(.linear(duration: stepTime)) {
                    let maxOffset = contentHeight - ( UIScreen.main.bounds.height - 200)
                    if isScrollingDown {
                        if scrollOffset < maxOffset {
                            scrollOffset += scrollSpeed
                        } else {
                            isScrollingDown = false
                        }
                    } else {
                        if scrollOffset > 0 {
                            scrollOffset -= scrollSpeed
                        } else {
                            isScrollingDown = true
                        }
                    }
                }
            }
/*
            HStack(spacing: 30) {
                Button(action: { isScrolling = false }) {
                    Label("Pause", systemImage: "pause.fill")
                }
                Button(action: { isScrolling = true }) {
                    Label("Resume", systemImage: "play.fill")
                }
            }
            .font(.title2)
            .padding()*/
           
        }.edgesIgnoringSafeArea([.horizontal,.vertical])
           
    }
}
struct VerticalOffsetScrollView<Content: View>: UIViewRepresentable {
    var content: () -> Content
    @Binding var offset: CGFloat
    @Binding var isUserInteracting: Bool

    init(offset: Binding<CGFloat>, isUserInteracting: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._offset = offset
        self._isUserInteracting = isUserInteracting
        self.content = content
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = false

        let hostedView = UIHostingController(rootView: content())
        hostedView.view.translatesAutoresizingMaskIntoConstraints = false
        hostedView.view.backgroundColor = .clear

        scrollView.addSubview(hostedView.view)

        NSLayoutConstraint.activate([
            hostedView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostedView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostedView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostedView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostedView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        UIView.animate(withDuration: 0.05) {
            uiView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
        }
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: VerticalOffsetScrollView

        init(_ parent: VerticalOffsetScrollView) {
            self.parent = parent
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.parent.offset = scrollView.contentOffset.y
            }
           // parent.offset = scrollView.contentOffset.y
        }

        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            parent.isUserInteracting = true
        }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate {
                parent.isUserInteracting = false
            }
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            parent.isUserInteracting = false
        }
    }
}
