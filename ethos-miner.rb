require 'formula'

class EthosMiner < Formula

  version '0.1'
  homepage ""

  url 'http://officebob.media.mit.edu:8888/miner?token=' + ENV['ETHOS_TOKEN']
  # url 'http://127.0.0.1:8888/miner?token=' + ENV['ETHOS_TOKEN']
  sha1 "32920838b3283066d6609c9a85d964bf6241960d"
  # sha1 ""

  depends_on 'cmake' => :build
  depends_on 'boost' => ["c++11", "with-python"]
  # depends_on 'pkg-config' => :build
  depends_on 'qt5'
  depends_on 'cryptopp'
  depends_on 'miniupnpc'
  depends_on 'leveldb'
  depends_on 'gmp'
  depends_on 'curl'
  depends_on 'jsonrpc'
  depends_on 'pyasn1' => :python

  option "with-local", "Url is local" # TODO
  option 'without-jsonrpc', "Build without JSON-RPC dependency"
  option "without-paranoia", "Build with -DPARANOIA=0"
  option 'with-vmtrace', "Build with VMTRACE"

  def install
    args = *std_cmake_args
    args << "-DLANGUAGES=0"
    args << "-DCMAKE_BUILD_TYPE=brew"
    args << "-DVMTRACE=1" if build.include? "with-vmtrace"
    args << "-DPARANOIA=0" if build.include? "without-paranoia"


    # handle ethos
    if File.exist?('~/.pydistutils.cfg')
      system "cp ~/.pydistutils.cfg ~/.pydistutils.cfg.orig"
    end

    system "printf '[install]\ninstall_lib = ~/Library/Python/$py_version_short/lib/python/site-packages' > ~/.pydistutils.cfg"
    system "mkdir -p ~/Library/Python/2.7/lib/python/site-packages"
    if File.exist?('/usr/bin/easy_install')
      system "/usr/bin/easy_install ./ethos-0.1-py2.7.egg"
    else
      system "`which easy_install` ./ethos-0.1-py2.7.egg"
    end
    system "rm ~/.pydistutils.cfg"

    if File.directory?('~/.ethos/')
      system "mkdir ~/.ethos"
    end
    system "cp -r cfg ~/.ethos"

    if File.exist?('~/.pydistutils.cfg.orig')
      system "mv ~/.pydistutils.cfg.orig ~/.pydistutils.cfg"
    end

    # handle ethreum
    system "cmake", *args
    system "make"
    system "make", "install"

    # symlink
    bin.install_symlink bin/"ethosd"

  end

  test do
    system "ethosd"
    system "eth"
  end

end
__END__
