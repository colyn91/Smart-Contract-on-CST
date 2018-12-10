pragma solidity ^0.4.23;


contract CST {

    struct CSTask {
        address taskID;
        uint256 predicate;
        uint256 hashvc;
	uint256 enct;
	uint256 reward;
	uint256 pkt;
	uint256 enck; 
	uint256 encr;
	bool state;
    }
    
    CSTask [] public task;
    CSTask [] public tmp;
    CSTask tmpTask;
    address public SGX;
    uint256 public random;
    
    address public owner;


    event _uploadTask(address indexed requester);
	 event _uploadPK(address indexed requester);
    event _getTask(address indexed requester);
	event _executeTask(address indexed requester);
    event _noFind(address indexed requester);
   
	
    function CST() public{
      owner = msg.sender;
	  SGX = 0x6d1c59cbe0c142e02754b648d8d5e41a84848558;
    }

    function() payable public {
      // for now, have ticket purchasing only through functions
      // for sanity purposes
      revert();
    }

    
    function uploadTask(uint256 hashVerifyCode, uint256 predicate, uint256 encTask, uint64 taskPrice) payable public returns (address) {
      require(msg.value == taskPrice); 
      tmpTask.taskID = msg.sender;
      tmpTask.predicate = predicate;
	  tmpTask.hashvc = hashVerifyCode;
	  tmpTask.enct = encTask;
	  tmpTask.reward = taskPrice;
	  tmpTask.state = false;
	  task.push(tmpTask);
      _uploadTask(msg.sender);
      return tmpTask.taskID;
    }
	
	function uploadPK(address taskID, uint256 publicKey, uint256 encKey) public returns (bool){
          require(msg.sender == taskID);
	  uint256 i;
	  for(i = 0; i < task.length; i++)
         {
            if(task[i].taskID == taskID)
            {
              task[i].pkt = publicKey;
	      task[i].enck = encKey;
	      _uploadPK(msg.sender);
   	      return true;
              break;
            }
            else
            {
	      _noFind(msg.sender);
              return false;
            }
         }
	  	  

	}

	
    function getTask(uint256 attribute) public {
      uint256 i = 0;
	  while(i < task.length){
		if(task[i].state == false && task[i].predicate == attribute)
		{
			tmp.push(task[i]);
		}
	  }      

      _getTask(msg.sender);
           
    }

    function executeTask (address taskID, bytes32 hash, uint8 v, bytes32 r, bytes32 s, uint256 encResult) public returns (bool) {
         uint256 i;
         uint256 num;
		 address recover = ecrecover(hash, v, r, s);
         for(i = 0; i < task.length; i++)
         {
            if(taskID == task[i].taskID)
            {
              num = i;
              if(recover == SGX)
				{
					task[num].state = true;
					task[num].encr = encResult;
					msg.sender.transfer(task[num].reward);
					_executeTask(msg.sender);
					return true; 
				}
			  else
				{		
					task[num].state = false;
					return false;
				}         
            }
            else
            {
              return false;
            }
         }		 
		 
                
         
       }


    function getHC(address taskID) public view returns (uint256){
	     uint256 i;
         uint256 num;
		 for(i = 0; i < task.length; i++)
         {
            if(taskID == task[i].taskID)
            {
              num = i;
              return task[num].hashvc;			  
            }
            else
            {
              return 0;
            }
         }
		 
         
    }
	
	function getResult(address taskID) public view returns (uint256){
	     uint256 i;
         uint256 num;
		 for(i = 0; i < task.length; i++)
         {
            if(taskID == task[i].taskID)
            {
              num = i;
              return task[num].encr;
            }
            else
            {
              return 0;
            }
         }
		 
         
    }

    function getK(address taskID) public view returns (uint256){
	     uint256 i;
         uint256 num;
		 for(i = 0; i < task.length; i++)
         {
            if(taskID == task[i].taskID)
            {
              num = i;
              return task[num].enck;
            }
            else
            {
              return 0;
            }
         }
		 
         
    }
    function getTmp() public view returns (address)
    {
         return tmpTask.taskID;
    }
    function getLength() public view returns (uint256)
    {
  	return task.length;
     }
 

}


