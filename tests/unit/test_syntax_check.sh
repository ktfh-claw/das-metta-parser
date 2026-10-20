#!/bin/bash

echo "tests/data/special_cases.metta" &&\
./scripts/run.sh syntax_check ./tests/data/special_cases.metta &&\
echo "tests/data/animals.metta" &&\
./scripts/run.sh syntax_check ./tests/data/animals.metta &&\
echo "tests/data/type_defs.metta" &&\
./scripts/run.sh syntax_check ./tests/data/type_defs.metta &&\
echo "tests/data/gencode_nodes.metta" &&\
./scripts/run.sh syntax_check ./tests/data/gencode_nodes.metta &&\
echo "tests/data/gencode_edges.metta" &&\
./scripts/run.sh syntax_check ./tests/data/gencode_edges.metta &&\
echo "tests/data/hocomoco_nodes.metta" &&\
./scripts/run.sh syntax_check ./tests/data/hocomoco_nodes.metta

# Fork-local addition: bare angle symbols must lex truthfully
# (previously < and > were silently dropped by the flex default rule)
echo "tests/data/bare_angle.metta"
BARE_ANGLE_OUTPUT=$(./scripts/run.sh syntax_check ./tests/data/bare_angle.metta)
if [[ $? -ne 0 ]] || [[ "$BARE_ANGLE_OUTPUT" != *"Syntax check OK ("* ]]; then
    echo "FAIL: tests/data/bare_angle.metta did not pass syntax check" >&2
    exit 1
fi

# Fork-local addition: parse_error.metta must fail cleanly
# (exit code 1, no "Syntax check OK" on stdout, "Parse FAILED" on stdout)
echo "tests/data/parse_error.metta"
PARSE_ERROR_OUTPUT=$(./scripts/run.sh syntax_check ./tests/data/parse_error.metta)
PARSE_ERROR_EXIT_CODE=$?
if [[ $PARSE_ERROR_EXIT_CODE -ne 1 ]] || [[ "$PARSE_ERROR_OUTPUT" == *"Syntax check OK"* ]] || [[ "$PARSE_ERROR_OUTPUT" != *"Parse FAILED"* ]]; then
    echo "FAIL: tests/data/parse_error.metta did not fail as expected" >&2
    exit 1
fi
