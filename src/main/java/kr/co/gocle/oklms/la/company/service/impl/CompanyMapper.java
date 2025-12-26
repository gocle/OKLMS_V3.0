package kr.co.gocle.oklms.la.company.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gocle.oklms.la.company.vo.CompanyVO;
import egovframework.com.cmm.LoginVO;

@Mapper
public interface CompanyMapper {

	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listCompany(CompanyVO companyVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listAllCompany(CompanyVO companyVO) throws Exception;
	
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listCompanySearch(CompanyVO companyVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listCompanySearch1(CompanyVO companyVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listCompanyTraningProcess(CompanyVO companyVO) throws Exception;

	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listCompanyTraningProcessSearch(CompanyVO companyVO) throws Exception;

	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * CompanyVO
	 */
	CompanyVO getCompany(CompanyVO companyVO) throws Exception;

	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int insertCompany(CompanyVO companyVO) throws Exception;
	
	/**
	 * 정보를 단건 저장하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int updateCompanyMember(CompanyVO companyVO) throws Exception;

	/**
	 * 정보를 수정하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * String
	 */
	int updateCompany(CompanyVO companyVO) throws Exception;

	/**
	 * 정보를 삭제하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * int
	 */
	int deleteCompany(CompanyVO companyVO) throws Exception;
	
	
	
	/**
	 * 정보를 삭제하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * int
	 */
	int deleteCcnCompany(CompanyVO companyVO) throws Exception;
	
	/**
	 * 정보를 삭제하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * int
	 */
	int deleteCcnMappingCompany(CompanyVO companyVO) throws Exception;
	
	/**
	 * 정보를 삭제하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * int
	 */
	int insertCcnCompany(CompanyVO companyVO) throws Exception;

	
	/**
	 * 정보를 사업자 번호 중복 체크 Count하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * int
	 */
	int getCompanyNoCnt(CompanyVO companyVO) throws Exception;

	/**
	 * 단건 조회하는 SQL 을 호출한다.
	 * @param memberVO
	 * @return
	 * MemberVO
	 */
	String getCompanyName(String companyName) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listCcnCompany(CompanyVO companyVO) throws Exception;
	
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listCcnMappingCompany(CompanyVO companyVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	List<CompanyVO> listCcnMember(CompanyVO companyVO) throws Exception;
	
	/**
	 * 목록은 조회하는 SQL 을 호출한다.
	 * @param companyVO
	 * @return
	 * List<CompanyVO>
	 */
	String getMyCompanyCcn(CompanyVO companyVO) throws Exception;
	
	List<CompanyVO> listCompanyStat(CompanyVO companyVO) throws Exception;
	
	List<CompanyVO> listCompanyStat1(CompanyVO companyVO) throws Exception;
	
	List<CompanyVO> listMember(CompanyVO companyVO) throws Exception;
	
	 
	CompanyVO mainCompanyStat () throws Exception;
	
	CompanyVO mainCompanyStatCnt () throws Exception;
	
	
	int updateMemberPw(LoginVO loginVO) throws Exception;
	
	
	int updateTempMemberPw(LoginVO loginVO) throws Exception;
	
	
	List<LoginVO> listPwMember(LoginVO loginVO) throws Exception;
	
	List<LoginVO> listPwTempMember(LoginVO loginVO) throws Exception;
	
	
}
