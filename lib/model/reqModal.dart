class Request {
  String workerName,workerCity,workerPhone,workerImg,workerUid;
  String hirerName,hirerCity,hirerPhone,hirerImg,hirerUid;
  String date;
  bool isAccept=false;

  Request({this.hirerUid,this.workerUid,this.hirerName,this.hirerPhone,this.hirerImg,this.workerImg,this.workerName,this.workerCity,this.hirerCity,this.date,this.isAccept,this.workerPhone});
}