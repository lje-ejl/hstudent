package kr.kosmo.jobkorea.tut.service;

import java.util.List;
import java.util.Map;
import kr.kosmo.jobkorea.tut.model.LectureStudentInfoModel;

public interface LectureStudentInfoService {

   List<LectureStudentInfoModel> showLectureList(Map<String, Object> paramMap) throws Exception;

   List<LectureStudentInfoModel> showLectureInfo(Map<String, Object> paramMap) throws Exception;

   List<LectureStudentInfoModel> showStudentsInfo(Map<String, Object> paramMap) throws Exception;

 

   void approveUpdate1(Map<String, Object> paramMap) throws Exception;

   void attendanceUpdate1(Map<String, Object> paramMap) throws Exception;
   

   void approveUpdate2(Map<String, Object> paramMap) throws Exception;

   void attendanceUpdate2(Map<String, Object> paramMap) throws Exception;

   void deleteStudent(Map<String, Object> paramMap) throws Exception;

   void decreasePrePnum(Map<String, Object> paramMap) throws Exception;

   void setApv(Map<String, Object> paramMap) throws Exception;  

   
}