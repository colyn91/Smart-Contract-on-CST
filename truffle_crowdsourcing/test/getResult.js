const CST = artifacts.require('./CST.sol')
contract('CST', function(accounts) 
{ 
    var fromJson = {from : web3.eth.accounts[0]};
    var addr = web3.eth.accounts[0];
    var myDate1 = new Array();
    var myDate2 = new Array();
    var tmp_result = 0;
    var result = 0;
    var num = 0;
    var current;
    var average;
    var MAX = 0;
    var MIN = 10000000;
    var N = 50;  //Test times
    var i;
    var j = 0;

    it("Test time of getResult...", function() 
    {
        var PC = CST.at("0x4cd3cd13d7c26d164e03e57567729cf737e8e606");
        console.log("============  Initially ===================");
		
        return PC.getTmp().then (function ()
        {
            timer(PC.getResult, "0x78bb4db7484ef49b836d90c37f45ea12a11bccbc", N);

            function timer(fn, a, total) 
            {
                i = 0;
                while(i < total)
                {
                    myDate1[i] = new Date().getTime();
                    fn(a).then(function(result)
                    {
                        
                        console.log("Transaction address---" + result);
                        myDate2[num] = new Date().getTime();
                        current = myDate2[num] - myDate1[num];
                        result = tmp_result + current;                    
                        tmp_result = result;
                        if(current > MAX)
                        {
                            MAX = current;
                        }    
                        if(current < MIN)
                        {
                            MIN = current;
                        } 
                        num ++;
                        average = result/num;
                        console.log("Total Running time of " + num + " times---" + result);
                        console.log("Average time ---" + average);
                        console.log("MAX time ---" + MAX);
                        console.log("MIN time ---" + MIN);
                    });                    
                    i ++;                    
                }  
    
            }
           
        });
    });

});

