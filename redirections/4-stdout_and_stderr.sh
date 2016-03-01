#!/bin/bash
echo $2 | tee /tmp/4-stdout_and_stderr
$1
$1 2>> /tmp/4-stdout_and_stderr

#!/bin/bash
#mv
#mv 2>> /tmp/3-only_log_stderr