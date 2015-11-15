#!/usr/bin/env ruby

require 'uri'
require 'pg'


uri = URI.parse('postgres://zhqqkzyehbvsah:1UtTG9XdHEvsaFFi602V2AKl63@ec2-107-21-219-235.compute-1.amazonaws.com:5432/dc72999lmnqk8')

begin 
    connection = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)    
    puts 'connected...'
    puts "Enter the non primary Key value (a.Statecode or b.CITY)"    
    opt=gets
    q_key="Birmingham"
    col="CITY"   
    case opt.chomp
    when 'a'
         col="STABBR"
         puts "Enter the Statecode value:"
         q_key=gets
    when 'b'
         col="CITY"
	 puts "Enter the city value:"
	 q_key=gets
    else
        puts "Enter the correct non primary key" 
    end
    q_key=q_key.chomp
  
    query_result= connection.exec("SELECT * from univs where "+col+"='"+q_key+"' limit 20;");
    if unless query_result.nil? or query_result == 0
	    puts "The key results are :\n"
    	    puts "UNITID | OPEID | opeid6 | INSTNM | CITY | STABBR | INSTURL"
	    query_result.each{
		unitID=query_result[0]['unitid']
		opeID=query_result[0]['opeid']
		opeid6=query_result[0]['opeid6']
		insTNM=query_result[0]['instnm']
		city=query_result[0]['city']
		state=query_result[0]['stabbr']
		instURL=query_result[0]['insturl']		
 		puts "#{unitID} | #{opeID} | #{opeid6} | #{insTNM} | #{city} | #{state} | #{instURL}"
	    }
	    end
    end   
    connection.close
    puts 'Connection closed'
end


	
