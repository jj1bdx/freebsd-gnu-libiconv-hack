# Created by: Maxim Sobolev <sobomax@FreeBSD.org>
# $FreeBSD: converters/libiconv/Makefile 331388 2013-10-23 15:05:04Z uqs $

PORTNAME=	libiconv
PORTVERSION=	1.14
PORTREVISION=	1
CATEGORIES=	converters devel
MASTER_SITES=	GNU

MAINTAINER=	gnome@FreeBSD.org
COMMENT=	A character set conversion library

GNU_CONFIGURE=	yes
LIBTOOLFILES=	configure libcharset/configure preload/configure
CONFIGURE_ARGS=	--enable-static \
		--without-libintl-prefix \
		--docdir=${DOCSDIR}
USE_LDCONFIG=	yes
CONFIGURE_ENV=	gl_cv_cc_visibility="no" \
		am_cv_func_iconv="yes" \
		am_cv_proto_iconv_arg1="const"
MAKE_JOBS_UNSAFE=	yes

MAN1=		iconv.1
MAN3=		iconv.3 iconv_open.3 iconv_open_into.3 iconv_close.3 iconvctl.3

OPTIONS_DEFINE=	ENCODINGS PATCHES
OPTIONS_DEFAULT=ENCODINGS
ENCODINGS_DESC=	Include extra character sets
PATCHES_DESC=	Apply patches to fix CP932, add EUCJP-MS

NO_STAGE=	yes
.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MENCODINGS}
CONFIGURE_ARGS+=	--enable-extra-encodings
.endif

.if ${PORT_OPTIONS:MPATCHES}
PATCH_SITES+=	http://apolloron.org/software/libiconv-1.14-ja/
PATCH_SITES+=	${MASTER_SITE_LOCAL}
PATCH_SITE_SUBDIR+=	kwm
PATCHFILES+=	${DISTNAME}-ja-1.patch.gz
PATCH_DIST_STRIP+=	-p1
.endif

post-patch:
	@${REINPLACE_CMD} -e 's:ei_ksc5601:ei_euc_kr:g' ${WRKSRC}/lib/aliases.h
	@${REINPLACE_CMD} -e 's:gawk:awk:g' ${WRKSRC}/configure \
		${WRKSRC}/libcharset/configure \
		${WRKSRC}/preload/configure

.include <bsd.port.pre.mk>

#.if exists(/usr/include/iconv.h)
#IGNORE=		converters/libiconv should not be used with iconv from base. \
#Please fix the port which tries to use it
#.endif

.include <bsd.port.post.mk>
