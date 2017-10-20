class Dump1090 < Formula
  homepage "https://github.com/antirez/dump1090"
  url "https://github.com/antirez/dump1090.git", :using => :git, :revision => '823631979b74f83caa48da69c86f8967e4c17c47'

  depends_on 'pkg-config' => :build
  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'librtlsdr'
  
  # add automake
  patch :DATA

  def install
    system "aclocal"
    system "autoconf"
    system "automake --add-missing"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

end

__END__
From 3eafd4fcf31096d8b9ff36f3bce45e17ff132e00 Mon Sep 17 00:00:00 2001
From: jasonpritchard <1500132+jasonpritchard@users.noreply.github.com>
Date: Sat, 1 Aug 2015 23:08:01 -0700
Subject: [PATCH] added automake

---
 Makefile     | 15 ---------------
 Makefile.am  |  6 ++++++
 configure.ac |  9 +++++++++
 3 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100644 Makefile
 create mode 100644 Makefile.am
 create mode 100644 configure.ac

diff --git a/Makefile b/Makefile
deleted file mode 100644
index f9637b7..0000000
--- a/Makefile
+++ /dev/null
@@ -1,15 +0,0 @@
-CFLAGS?=-O2 -g -Wall -W $(shell pkg-config --cflags librtlsdr)
-LDLIBS+=$(shell pkg-config --libs librtlsdr) -lpthread -lm
-CC?=gcc
-PROGNAME=dump1090
-
-all: dump1090
-
-%.o: %.c
-	$(CC) $(CFLAGS) -c $<
-
-dump1090: dump1090.o anet.o
-	$(CC) -g -o dump1090 dump1090.o anet.o $(LDFLAGS) $(LDLIBS)
-
-clean:
-	rm -f *.o dump1090
diff --git a/Makefile.am b/Makefile.am
new file mode 100644
index 0000000..8487696
--- /dev/null
+++ b/Makefile.am
@@ -0,0 +1,6 @@
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS = dump1090
+dump1090_SOURCES = dump1090.c anet.c
+
+dump1090_CFLAGS = $(RTLSDR_CFLAGS) -O2 -Wall -W 
+dump1090_LDADD = $(RTLSDR_LIBS) -lpthread -lm
diff --git a/configure.ac b/configure.ac
new file mode 100644
index 0000000..fcb199c
--- /dev/null
+++ b/configure.ac
@@ -0,0 +1,9 @@
+AC_INIT([dump1090], [0.1], [antirez@gmail.com])
+AM_INIT_AUTOMAKE
+AC_PROG_CC
+
+AC_CONFIG_FILES([Makefile])
+
+PKG_CHECK_MODULES([RTLSDR], [librtlsdr >= 0.5.3])
+
+AC_OUTPUT
-- 
2.4.6

