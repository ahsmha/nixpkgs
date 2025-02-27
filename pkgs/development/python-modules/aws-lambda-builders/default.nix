{ lib
, buildPythonPackage
, fetchFromGitHub
, mock
, parameterized
, pyelftools
, pytestCheckHook
, pythonOlder
, six
}:

buildPythonPackage rec {
  pname = "aws-lambda-builders";
  version = "1.17.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "awslabs";
    repo = "aws-lambda-builders";
    rev = "refs/tags/v${version}";
    hash = "sha256-EkAtRqUHwmH0LG/bkXBbZ3TMgXDtcqLfUBySPbrgWmc=";
  };

  propagatedBuildInputs = [
    six
  ];

  checkInputs = [
    mock
    parameterized
    pyelftools
    pytestCheckHook
  ];

  disabledTests = [
    # CLI don't work in the sandbox
    "test_run_hello_workflow"
    # Don't tests integrations
    "TestCustomMakeWorkflow"
    "TestDotnet31"
    "TestDotnet6"
    "TestGoWorkflow"
    "TestJavaGradle"
    "TestJavaMaven"
    "TestNodejsNpmWorkflow"
    "TestNodejsNpmWorkflowWithEsbuild"
    "TestPipRunner"
    "TestPythonPipWorkflow"
    "TestRubyWorkflow"
  ];

  pythonImportsCheck = [
    "aws_lambda_builders"
  ];

  meta = with lib; {
    description = "Tool to compile, build and package AWS Lambda functions";
    homepage = "https://github.com/awslabs/aws-lambda-builders";
    longDescription = ''
      Lambda Builders is a Python library to compile, build and package
      AWS Lambda functions for several runtimes & frameworks.
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ dhkl ];
  };
}
