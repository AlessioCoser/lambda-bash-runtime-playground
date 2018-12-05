# Custom Runtime
https://docs.aws.amazon.com/lambda/latest/dg/runtimes-walkthrough.html


# Deploy runtime

```
./deploy_runtime.sh bash-runtime
```

# Deploy function using the runtime
first arg: role name
second arg: runtime-name
third arg: runtime-version
fourth arg: function-name
```
./deploy_function.sh lambda_basic_execution bash-runtime 3 bash-function
```

# Test Function

```
aws lambda invoke \
  --function-name bash-function \
  --payload '{"text":"Hello"}' response.txt \
&& cat response.txt \
&& rm response.txt
```