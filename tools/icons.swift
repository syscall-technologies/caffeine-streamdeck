// Renders the key images from SF Symbols: swift tools/icons.swift com.seb.caffeine.sdPlugin/imgs
import AppKit
let out = CommandLine.arguments[1]
func render(_ name: String, _ size: CGFloat, symbol: String = "cup.and.saucer.fill", bg: NSColor?, fg: NSColor) {
  let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(size), pixelsHigh: Int(size), bitsPerSample: 8,
    samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
  NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
  if let bg { bg.setFill(); NSBezierPath(rect: NSRect(x: 0, y: 0, width: size, height: size)).fill() }
  let cfg = NSImage.SymbolConfiguration(pointSize: size * (bg == nil ? 0.7 : 0.5), weight: .semibold)
    .applying(.init(paletteColors: [fg]))
  let sym = NSImage(systemSymbolName: symbol, accessibilityDescription: nil)!.withSymbolConfiguration(cfg)!
  sym.draw(in: NSRect(x: (size - sym.size.width) / 2, y: (size - sym.size.height) / 2, width: sym.size.width, height: sym.size.height))
  NSGraphicsContext.current = nil
  try! rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: "\(out)/\(name).png"))
}
for (suffix, scale) in [("", 1.0), ("@2x", 2.0)] {
  render("on\(suffix)", 72 * scale, symbol: "cup.and.heat.waves.fill", bg: NSColor(red: 0.85, green: 0.5, blue: 0.1, alpha: 1), fg: .white)
  render("off\(suffix)", 72 * scale, bg: NSColor(white: 0.13, alpha: 1), fg: NSColor(white: 0.45, alpha: 1))
  render("plugin\(suffix)", 256 * scale, symbol: "cup.and.heat.waves.fill", bg: NSColor(red: 0.85, green: 0.5, blue: 0.1, alpha: 1), fg: .white)
  render("category\(suffix)", 28 * scale, bg: nil, fg: .white)
  render("action\(suffix)", 20 * scale, bg: nil, fg: .white)
}
