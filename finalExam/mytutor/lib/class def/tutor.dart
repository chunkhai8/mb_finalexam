class Tutor {
  String? tutorid ;
  String? tutoremail ;
  String? tutorphone;
  String? tutorname;
  String? tutorpassword;
  String? tutordescription;
  String? tutordatereg;
  String? subjectname;

  Tutor(
      {this.tutorid,
      this.tutoremail,
      this.tutorphone,
      this.tutorname,
      this.tutorpassword,
      this.tutordescription,
      this.tutordatereg,
      this.subjectname,
      });

  Tutor.fromJson(Map<String, dynamic> json) {
    tutorid = json['tutor_id'];
    tutoremail = json['tutor_email'];
    tutorphone = json['tutor_phone'];
    tutorname = json['tutor_name'];
    tutorpassword = json['tutor_password'];
    tutordescription = json['tutor_description'];
    tutordatereg = json['tutor_datereg'];
    subjectname = json['subjectname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tutor_id'] = tutorid;
    data['tutor_email'] = tutoremail;
    data['tutor_phone'] = tutorphone;
    data['tutor_name'] = tutorname;
    data['tutor_password'] = tutorpassword;
    data['tutor_description'] = tutordescription;
    data['tutor_datereg'] = tutordatereg;
    data['subjectname'] = subjectname;
    return data;
  }
}