Map<String, String> DecodeQR(String QRresult) {
  if (QRresult.startsWith('{{Check Out},{')) {
    var ans = {'status': 'Check Out'};
    int count = 14;
    while (QRresult[count] != '}') {
      count++;
    }
    count -= 14;
    ans['Unique ID'] = QRresult.substring(14, 14 + count);
    ans['Reason'] = QRresult.substring(17 + count, QRresult.length - 2);

    return ans;
  } else if (QRresult.startsWith('{{Check In}')) {
    var ans = {'status': 'Check In'};
    int count = 13;
    while (QRresult[count] != '}') {
      count++;
    }
    count -= 13;
    ans['Unique ID'] = QRresult.substring(13, 13 + count);
    ans['Document ID'] = QRresult.substring(16 + count, QRresult.length - 1);

    return ans;
  } else {
    print("invalid QR");
    var ans = {'status': 'Invalid'};
    return ans;
  }
}

void main() {
  //print(DecodeQR("{{Check Out},{31},{shop}}"));
  print(DecodeQR("{{Check In},{202251127},{sffhsflfhlkj}"));
}
