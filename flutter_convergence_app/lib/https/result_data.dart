//网络结果数据

class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});

  @override
  String toString() {
    return "result:$result code:$code data:$data headers:$headers";
  }
}
