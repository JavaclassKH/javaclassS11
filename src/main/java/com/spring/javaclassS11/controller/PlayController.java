package com.spring.javaclassS11.controller;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS11.service.PlayService;
import com.spring.javaclassS11.vo.IVEQuizVO;
import com.spring.javaclassS11.vo.RandomSongRecommandVO;

@Controller
public class PlayController {
	
	@Autowired
	PlayService playService;
	
	@RequestMapping(value = "/play/randomSongRecommand" , method = RequestMethod.GET)
	public String randomSongRecommandGet(Model model) {
		return "play/randomSongRecommand";
	}
	
	// 원영적사고 
	@RequestMapping(value = "/play/luckyvicky" , method = RequestMethod.GET)
	public String luckyvickyGet() { return "test/luckyvicky"; }
	
	// 검색해서 노래 추천
	@ResponseBody
	@RequestMapping(value = "/play/randomSongRecommandSearch" , method = RequestMethod.POST)
	public RandomSongRecommandVO randomSongRecommandSearchPost(Model model, String search) {
		RandomSongRecommandVO vo = playService.getRandomSongRecommandSearch(search);
		return vo; 
	}
	
	// 랜덤으로 노래 추천
	@ResponseBody
	@RequestMapping(value = "/play/randomSongRecommand" , method = RequestMethod.POST)
	public RandomSongRecommandVO randomSongRecommandPost(Model model, String search) {
		RandomSongRecommandVO vo = playService.getRandomSongRecommand();
		return vo; 
	}
	
	// 퀴즈파크 초기화면 (IVEQuiz.jsp를 불러주고 이 다음부터는 iframe 안에서 움직이게 된다)
	@RequestMapping(value = "/play/IVEQuiz/{part}" , method = RequestMethod.GET)
	public String IVEQuizGet(Model model, HttpServletRequest request, HttpSession session,
		@PathVariable (name = "part", required = false) String part) {		
		if(part.equals("main")) model.addAttribute("part", part); 
		return "play/IVEQuiz";	
	}
	
	// 퀴즈파크에서 iframe 내에 메인화면 불러오기
	@RequestMapping(value = "/play/quizMain" , method = RequestMethod.GET)
	public String iframeQuizMainGet() { return "play/quizMain"; }
	
	// 아이브퀴즈 
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/play/IVEInfoQuiz/{check}" , method = RequestMethod.GET)
	public String iframeIVEInfoQuizGet(@PathVariable(name="check") String check, HttpSession session, Model model,
		@RequestParam(name="score", defaultValue = "1", required = false) int score) {
		IVEQuizVO vo = null;
		
		if(check.equals("before")) return "play/IVEInfoQuiz";
		else if(check.equals("start")){
			//ArrayList<String> quizAnswers = (ArrayList<String>) session.getAttribute("quizAnswer");
			Set<String> quizAnswers = (Set<String>) session.getAttribute("quizAnswer");
      if (quizAnswers == null) {
      	vo = playService.getIVEInfoQuizList("IVEInfoQuiz");
        quizAnswers = new HashSet<String>();
        quizAnswers.add(vo.getQuizAnswer());
        session.setAttribute("quizAnswer", quizAnswers);  // 세션에 저장
			}
			else {  
				if(quizAnswers.size() != 10) {
					reroll:while(quizAnswers.size() != 10) { 
						vo = playService.getIVEInfoQuizList("IVEInfoQuiz");
						if(quizAnswers.contains(vo.getQuizAnswer())) continue reroll; 
						else {
							quizAnswers.add(vo.getQuizAnswer()); 
							session.setAttribute("quizAnswer", quizAnswers);
							break; 
						}
					}
				}
			}
      if(quizAnswers.size() != 10) model.addAttribute("check", "start");
      else if(quizAnswers.size() == 10) {
      	model.addAttribute("check", "finish");
      	if(quizAnswers.size() < 10) model.addAttribute("nowScore", (int)session.getAttribute("score"));
      }
			model.addAttribute("vo", vo);
			return "play/IVEInfoQuiz";
		}
		return "play/IVEInfoQuiz";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}

/*

System.out.println((int)session.getAttribute("quizOnlyTen")+"\n");
			
			keepGo : while((int) session.getAttribute("quizOnlyTen") > 10) {
				System.out.println("퀴즈의 IVEInfoQuiz파트 들어옴\n");
				
				if(session.getAttribute("quizOnlyTen") == null) {
					// 퀴즈 개수 카운트 : 10문제가 넘어가면 게임 끝내기
					System.out.println("퀴즈의 IVEInfoQuiz파트 카운트 시작부분 들어옴\n");
					session.setAttribute("quizOnlyTen", 1);
				}
				else if ((int)session.getAttribute("quizOnlyTen") <= 10){
					System.out.println("퀴즈의 IVEInfoQuiz파트 카운트 진행부분 들어옴\n");
					session.setAttribute("quizOnlyTen", (int)session.getAttribute("quizOnlyTen") + 1);
				}
				
			
				System.out.println("세션에 ArrayList로 담은 문제 카운트 : "+(int)session.getAttribute("quizOnlyTen"));
				
				IVEQuizVO quizVo = playService.getIVEInfoQuizList(part);	
				ArrayList<String> quizAnswers = (ArrayList<String>) session.getAttribute("quizAnswer");
				
				if(quizAnswers == null) quizAnswers = new ArrayList<String>();
				
				if(quizAnswers.contains(quizVo.getQuizAnswer())) {
					System.out.println("세션에 ArrayList로 담은 문제 정답 겹침!: " + quizVo.getQuizAnswer());
					continue keepGo;
				}
				session.setAttribute("quizAnswers",quizVo.getQuizAnswer());		
				System.out.println("세션에 ArrayList로 담은 문제 정답(문제중복방지) : "+(int)session.getAttribute("quizAnswer"));
				System.out.println("quizVo : " + quizVo);
				model.addAttribute("vo", quizVo);
				model.addAttribute("part", part);
				return "play/IVEQuiz";

==============================================================================================================


	IVEQuizVO vo = null;
		
		if(part.equals("IVEInfoQuiz")) {
			ArrayList<String> quizAnswers = (ArrayList<String>) session.getAttribute("quizAnswer");
			if(quizAnswers == null) {  // 퀴즈가 제출되지 않았음! 첫 문제!
				System.out.println("퀴즈 제출 X! vo에서 정답만 뽑아 session에 넣고 문제 출제!");
				vo = playService.getIVEInfoQuizList(part);  // 문제를 가져옴! 이것이 첫 문제!!!!!!!!!!
				quizAnswers = new ArrayList<String>(); // 새 객체를 추가해 담아주기
				quizAnswers.add(vo.getQuizAnswer()); // 첫 문제의 정답이 session에 저장됨! 이제부터 quizAnswers는 null이 아님
			}
			else {  // quizAnswers가 null이 아닌 것은 문제가 출제된 것이고, 중복방지와 문제 카운트를 시작해야 한다
 reroll:while(quizAnswers.size() < 11) { // 문제 카운트 시작! 10번째까지 문제를 내야 하니 11보다 작다 라는 조건
					vo = playService.getIVEInfoQuizList(part); // 문제를 가져온다
					if(quizAnswers.contains(vo.getQuizAnswer())) continue reroll; // 문제 중복인지 확인! 중복이면 다시 가져온다 
					else {
						quizAnswers = new ArrayList<String>(); // 새 객체를 추가해 담아주기
						quizAnswers.add(vo.getQuizAnswer()); // 중복이 아니면 session에 담기
						break; // session에 담아 중복방지와 카운트 추가를 해준 뒤 break로 빠져나가 model에 문제를 담고 보내준다!
					}
				}
			}
		}
		model.addAttribute("part", part);
		model.addAttribute("vo", vo);
		System.out.println(vo);
		return "play/IVEQuiz";
	}


==============================================================================================================


// 퀴즈파크 시작! (ajax 사용) 
	@ResponseBody
	@RequestMapping(value = "/play/IVEQuiz/{part}/{isStart}" , method = RequestMethod.GET)
	public IVEQuizVO IVEQuizStartGet(Model model, HttpServletRequest request, HttpSession session,
			@PathVariable (name = "part", required = false) String part, 		
			@PathVariable (name = "isStart", required = false) String isStart) {		
		IVEQuizVO vo = null;
		if(isStart.equals("start")) { // 아이브 상식퀴즈의 start버튼을 눌러서 퀴즈가 시작될 때 여기로 온다
			
			if(part.equals("IVEInfoQuiz")) { 
				ArrayList<String> quizAnswers = (ArrayList<String>) session.getAttribute("quizAnswer");
				if(quizAnswers == null) {  // 퀴즈가 제출되지 않았음! 첫 문제!
					System.out.println("퀴즈 제출 X! vo에서 정답만 뽑아 session에 넣고 문제 출제!");
					vo = playService.getIVEInfoQuizList(part);  // 문제를 가져옴! 이것이 첫 문제!!!!!!!!!!
					quizAnswers = new ArrayList<String>(); // 새 객체를 추가해 담아주기
					quizAnswers.add(vo.getQuizAnswer()); // 첫 문제의 정답이 session에 저장됨! 이제부터 quizAnswers는 null이 아님
				}
				else {  // quizAnswers가 null이 아닌 것은 문제가 출제된 것이고, 중복방지와 문제 카운트를 시작해야 한다
	 reroll:while(quizAnswers.size() < 11) { // 문제 카운트 시작! 10번째까지 문제를 내야 하니 11보다 작다 라는 조건
						vo = playService.getIVEInfoQuizList(part); // 문제를 가져온다
						if(quizAnswers.contains(vo.getQuizAnswer())) continue reroll; // 문제 중복인지 확인! 중복이면 다시 가져온다 
						else {
							quizAnswers = new ArrayList<String>(); // 새 객체를 추가해 담아주기
							quizAnswers.add(vo.getQuizAnswer()); // 중복이 아니면 session에 담기
							break; // session에 담아 중복방지와 카운트 추가를 해준 뒤 break로 빠져나가 model에 문제를 담고 보내준다!
						}
					}
				}
				
				model.addAttribute("part", part); 
			}
			else if(part.equals("IVELyricsQuiz")) {	
				model.addAttribute("part", part); 
			}
			else if(part.equals("commonQuiz")) { 
				model.addAttribute("part", part); 
			}
			else if(part.equals("nonsenseQuiz")) { 
				model.addAttribute("part", part); 
			}
			
		}
		
		
		return vo;	
	}
		

==============================================================================================================


// 퀴즈 진행시 왔다갔다 하며 작업할 곳 (ajax 사용 O)
	1. 퀴즈 카운트는 어디에 저장하고 계속 비교할까? (프론트에서? 백에서?(세션?))
	2. 정답을 맞췄을 때, 시간이 초과되었을 때 퀴즈카운트가 올라가야 함.
	※ 퀴즈 카운트를 따로 저장하지 말고 ArrayList로 session에 저장한 정답의 size를 비교해서 문제 낸 갯수를 구하는 건?
		이렇게 하면 ArrayList로 session에 저장한 정답과 선택한 보기의 비교는 프론트에서 처리 해서 정답,오답여부를 넘겨주게하고 
		오답시에는 오답인것만 프론트에서 표시하고, 정답일때와 시간초과일때를 구별할 수 있도록 항상 score를 넘겨서 점수에 추가하게 하자!
		시간초과일땐 0을 넘겨서 더하면 되니까! 백에서는 딱 size만 비교해서 10이 넘어가면 되면 끝내는 걸로?
		그러면 각각의 보기가 버튼이니까 해당 버튼을 눌렀을 때!
		1) 정답,오답여부 확인
		2-1) 정답이면 10이라는 값을 score에 담아서 ajax를 통해 아래 메소드로 돌아와서 사이즈 체크, 문제 중복방지, 점수 추가를 진행
		2-2) 시간초과이면 0이라는 값을 score에 담아서 ajax를 통해 아래 메소드로 돌아와서 사이즈 체크, 문제 중복방지, 점수 추가를 진행
		2-3) 정답이라면 ajax로 아래 메소드를 다녀간 뒤 타이머도 다시 10초로 초기화해서 재시작시켜야 함 
		
		
		
		- 게임 시작을 했다!!!!!!!!!! 
		1) 문제가 출제되었는지 아닌지를 먼저 확인! 
		퀴즈가 제출되지 않았다는 것을 확인할 수 있는 방법? session에 담겼는지를 보자


*/












