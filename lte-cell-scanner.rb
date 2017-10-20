class LteCellScanner < Formula
  homepage "https://github.com/Evrytania/LTE-Cell-Scanner"
  url "https://github.com/jasonpritchard/LTE-Cell-Scanner.git", :using => :git, :revision => '101388691b3186222add64bebc3cf8cf3c1ede5c'

  depends_on 'cmake' => :build
  depends_on 'librtlsdr'
  depends_on 'itpp'
  depends_on 'fftw'
  depends_on 'ncurses'
  depends_on 'boost'
  
  def install
    system "mkdir", "build"
    system "cd", "build"
    system "cmake", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "#{buildpath}"
    system "make"
    system "make", "install"
  end

end
