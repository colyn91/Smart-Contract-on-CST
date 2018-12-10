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

    it("Test time of uploadPK...", function() 
    {
        var PC = CST.at("0xe411bcf30e358843aa8b5df51493245c81713b25");
        console.log("============  Initially ===================");
		
        return PC.getTmp().then (function ()
        {
            timer(PC.uploadPK, "0x78bb4db7484ef49b836d90c37f45ea12a11bccbc", 0xd072b812a49f3c6ccbda896118bbca70f018a1934aac6175899970aad6cd6aa2,0xf40392bd6a8866ccc46651971b5313a2d3c28f03cf33143ff80c80f955df8ea8, N);

            function timer(fn, a, b, c, total) 
            {
                i = 0;
                while(i < total)
                {
                    myDate1[i] = new Date().getTime();
                    fn(a,b,c).then(function(hash)
                    {
                        
                        console.log("Transaction address---" + hash);
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

