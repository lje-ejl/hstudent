package kr.kosmo.jobkorea.tut.dao;

import java.util.List;
import java.util.Map;
import kr.kosmo.jobkorea.tut.model.LectureStudentInfoModel;

public interface LectureStudentInfoDao {

   public List<LectureStudentInfoModel> showLectureList(Map<String, Object> paramMap);

   public List<LectureStudentInfoModel> showLectureInfo(Map<String, Object> paramMap);

   public List<LectureStudentInfoModel> showStudentsInfo(Map<String, Object> paramMap);



   public List<LectureStudentInfoModel> approveUpdate1(Map<String, Object> paramMap);

   public List<LectureStudentInfoModel> attendanceUpdate1(Map<String, Object> paramMap);
   
   

   public List<LectureStudentInfoModel> approveUpdate2(Map<String, Object> paramMap);

   public List<LectureStudentInfoModel> attendanceUpdate2(Map<String, Object> paramMap);

   
   public void deleteStudent(Map<String, Object> paramMap);

   
   public void decreasePrePnum(Map<String, Object> paramMap);

   
   public void setApv(Map<String, Object> paramMap);  

 
}

