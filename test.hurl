GET https://httpbin.org/status/200
HTTP 200

#----------------------------------------

GET https://httpbin.org/get
[QueryStringParams]
param1: value1x
HTTP 200
[Asserts]
jsonpath "$.args.param1" == "value1x"

#----------------------------------------

POST https://httpbin.org/post
[FormParams]
field1: value1
field2: value2
HTTP 200
[Asserts]
jsonpath "$.form.field1" == "value1"
[Captures]
postedContentLength: jsonpath "$.headers.Content-Length"

#----------------------------------------

PUT https://httpbin.org/anything
{
    "prevReqContentLength": {{postedContentLength}}
}
HTTP 200
[Asserts]
# bug? (https://hurl.dev/docs/templates.html#types)
jsonpath "$.json.prevReqContentLength" == {{postedContentLength}}