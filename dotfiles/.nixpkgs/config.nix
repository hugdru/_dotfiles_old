{
  packageOverrides = pkgs: {
    php = pkgs.php54.merge {
      cfg = {
        imapSupport = true;
        ldapSupport = true;
        mhashSupport = true;
        mysqlSupport = true;
        mysqliSupport = true;
        pdo_mysqlSupport = true;
        libxml2Support = true;
        apxs2Support = true;
        bcmathSupport = true;
        socketsSupport = true;
        curlSupport = true;
        curlWrappersSupport = true;
        gettextSupport = true;
        pcntlSupport = true;
        postgresqlSupport = true;
        pdo_pgsqlSupport = true;
        readlineSupport = true;
        sqliteSupport = true;
        soapSupport = true;
        zlibSupport = true;
        opensslSupport = true;
        mbstringSupport = true;
        gdSupport = true;
        intlSupport = true;
        exifSupport = true;
        xslSupport = true;
        mcryptSupport = true;
        bz2Support = true;
        zipSupport = true;
        ftpSupport = true;
        fpmSupport = true;
        gmpSupport = true;
        mssqlSupport = true;
        ztsSupport = true;
        calendarSupport = true;
      };
    };
  };
}
