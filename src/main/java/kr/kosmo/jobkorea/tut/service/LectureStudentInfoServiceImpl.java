package kr.kosmo.jobkorea.tut.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.kosmo.jobkorea.tut.dao.LectureStudentInfoDao;
import kr.kosmo.jobkorea.tut.model.LectureStudentInfoModel;

@Service
public class LectureStudentInfoServiceImpl implements LectureStudentInfoService{

   @Autowired
   private LectureStudentInfoDao lectureStudentInfoDao;
   
   @Override
   public List<LectureStudentInfoModel> showLectureList(Map<String, Object> paramMap) throws Exception {
      List<LectureStudentInfoModel> lectureList = lectureStudentInfoDao.showLectureList(paramMap);
      return lectureList;
   }

   @Override
   public List<LectureStudentInfoModel> showLectureInfo(Map<String, Object> paramMap) throws Exception {
      List<LectureStudentInfoModel> lectureInfo = lectureStudentInfoDao.showLectureInfo(paramMap);
      return lectureInfo;
   }

   @Override
   public List<LectureStudentInfoModel> showStudentsInfo(Map<String, Object> paramMap) throws Exception {
      List<LectureStudentInfoModel> studentsInfo = lectureStudentInfoDao.showStudentsInfo(paramMap);
      return studentsInfo;
   }

   @Override
   public void approveUpdate1(Map<String, Object> paramMap) throws Exception {
	   List<LectureStudentInfoModel> approve = lectureStudentInfoDao.approveUpdate1(paramMap);
   }

   @Override
   public void attendanceUpdate1(Map<String, Object> paramMap) {
	   List<LectureStudentInfoModel> attendance = lectureStudentInfoDao.attendanceUpdate1(paramMap);
   }
   
   
   
   @Override
   public void approveUpdate2(Map<String, Object> paramMap) throws Exception {
	   List<LectureStudentInfoModel> approve = lectureStudentInfoDao.approveUpdate2(paramMap);
   }

   @Override
   public void attendanceUpdate2(Map<String, Object> paramMap) {
	   List<LectureStudentInfoModel> attendance = lectureStudentInfoDao.attendanceUpdate2(paramMap);
   }

	@Override
	public void deleteStudent(Map<String, Object> paramMap) throws Exception {
		lectureStudentInfoDao.deleteStudent(paramMap);
	}

	@Override
	public void decreasePrePnum(Map<String, Object> paramMap) throws Exception {
		lectureStudentInfoDao.decreasePrePnum(paramMap);
	}

	@Override
	public void setApv(Map<String, Object> paramMap) throws Exception {
		lectureStudentInfoDao.setApv(paramMap);
	}
}