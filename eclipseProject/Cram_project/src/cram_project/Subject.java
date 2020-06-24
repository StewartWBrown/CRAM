package cram_project;

import java.util.ArrayList;
import java.util.Date;

public class Subject {

	int workloads;
	ArrayList<Integer> workCompleted;
	Date startDate;
	Date endDate;
	Date examDate;
	ArrayList<Integer> remainingWork;
	
	public Subject(int _workloads, ArrayList<Integer> _workCompleted, Date _startDate, Date _endDate, Date _examDate) {
		this.workloads = _workloads;
		this.workCompleted = _workCompleted;
		this.startDate = _startDate;
		this.endDate = _endDate;
		this.examDate = _examDate;
		this.remainingWork = find_workload();
	}
	
	public ArrayList<Integer> find_workload() {
		ArrayList<Integer> workLoad = new ArrayList<Integer>();
		for(int i=1; i<workloads+1; i++) {
			if(!workCompleted.contains(i)) {
				workLoad.add(i);
			}
		}
		return workLoad;
	}
	
}
