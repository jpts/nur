{ lib
, ajpy
, buildPythonPackage
, fetchPypi
, fetchpatch
, pythonAtLeast
, httplib2
, urllib3
, certifi
, six
}:
buildPythonPackage rec {
  pname = "httplib2shim";
  version = "0.0.3";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-fGHa69k+15MN+d7U2/R/h9Najyk2PW45n7+f7JMPjRc=";
  };
  patches = [
    (fetchpatch {
      name = "fix-python-310-collections.patch";
      url = "https://patch-diff.githubusercontent.com/raw/GoogleCloudPlatform/httplib2shim/pull/16.patch";
      sha256 = "sha256-NjU8D2h2qS2QqgeDiMhqqUDbSqN4fGgb8BXQ93OYSaY=";
    })
  ];

  propagatedBuildInputs = [
    httplib2
    urllib3
    certifi
    six
  ];

  # work required
  doCheck = false;

  disabledTests = [
    "testGet301ViaHttps"
    "testGetUnknownServer"
    "testGetViaHttps"
    "testGetViaHttpsSpecViolationOnLocation"
    "testHeadRead"
    "testSniHostnameValidation"
    "test"
    "testSslCertValidation"
  ] ++ lib.optionals (pythonAtLeast "3.10") [
    "testWsseAlgorithm"
    "WsseAlgorithm"
  ];

  #postInstall = ''
  #'';

  meta = with lib; {
    description = "";
    homepage = "https://github.com/GoogleCloudPlatform/httplib2shim";
    license = licenses.mit;
    maintainers = with maintainers; [ jpts ];
  };
}
