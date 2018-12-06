# Custom Runtime
I followed [this AWS guide](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-walkthrough.html) and I scripted runtime and function creation.

# Prerequisites
- aws-cli installed
- AWS account configured
- An AWS IAM Role configured in order to be applied to the lambda function

# Deploy runtime

```
# USAGE: ./deploy_runtime.sh [runtime_name]

./deploy_runtime.sh bash-runtime
```

# Deploy function using the runtime
```
# USAGE: ./deploy_function.sh [role_name] [custom_runtime_name] [custom_runtime_version] [function_name]

./deploy_function.sh lambda_basic_execution bash-runtime 1 bash-function
```

# Test the Function
```
aws lambda invoke \
  --function-name bash-function \
  --payload '{"text":"Hello"}' response.txt \
&& cat response.txt \
&& rm response.txt
```