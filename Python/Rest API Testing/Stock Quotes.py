import requests

url = "https://assets.msn.com/service/Finance/Quotes?apikey=0QfOX3Vn51YCzitbLaRkTTBadtWpgTN8NZLW0C1SEM&activityId=043C43E8-50F4-430E-AA8A-307BBBE07D21&ocid=finance-finance::portfolio-Peregrine&market=en-in&fdhead=msnallexpusers,muidflt13cf,muidflt51cf,muidflt52cf,muidflt54cf,muidflt313cf,platagyedge1cf,pnehp1cf,platagyhp3cf,audexhp1cf,bingcollabhp2cf,compliancehp1cf,modsplitabu,prg-com-staging,platagyhz3cf,audexhz2cf,ads-bingdnp,artgly5cf,1s-bing-news,vebudumu04302020,prg-staginc,prg-ndauthrf2,prg-nodualauth,prg-tel-inhlist,prg-supersetntpc,prg-wpo-clctrl,1s-ffw-rankcc,prg-wpo-htipac,englishuxbundle,msnsports2cf,weather2cf,weather3cf,prg-wea-staginc,prg-1sw-wlsmy1,prg-1sw-t-ignaperct,preprg-1sw-spdiscar,prg-1sw-crxmt3,prg-1sw-gevte,prg-hp-grablue,prg-hp-tsc,prg-1sw-newspromo,prg-1sw-newsbkctt,prg-1sw-newsbkt,prg-1sw-newspreviewc,prg-fin-gm,1s-remotecompact,prg-adspeek,prg-wpo-sccls1g,prg-wpo-entfuzz,1s-br30min,btrecrow2,1s-winauthservice,1s-winsegservice,prg-1sw-grevtt,prg-1sw-rfipre,wf-sunny-first,prg-social-wea,1s-pagesegservice,prg-ias,prg-1sw-ms-cloud,prg-1sw-mscloudn-c,routentpring2t,prg-1s-p2pre,prg-prn-ssadmix2,prg-1sw-newsskip,prg-1sw-l2icon,1s-fcrypt-c,prg-newpc-lininsp,prg-prmt-crtdv2,prg-sbdarkt1c,prg-cookiesync,18105901,prg-wea-nortate,prg-1sw-splog,prg-1sw-swsvg,prg-1sw-swsvg3,prg-1sw-swsvg2,prg-1sw-nen3di,prg-1sw-pbpf1,prg-ctr-pnpc,prg-1sw-accu10,prg-1sw-hdukr,jcj9d730,prg-ntpentpc,prg-pin-taskbarc,prg-wtchscrlctrl,prg-1sw-swsvg4,prg-brotli,prg-1sw-hourly,prg-1sw-aqiv2,prg-1sw-tmptile,otvendor-t,prg-ukrimgintl2,prg-ukrimg,prg-ukrimgua2,prg-ukrimg,prg-sh-cadp2,prg-sh-synadpc,prg-upsaip-w1-t,prg-ntp-ach,prg-wtchcard1,prg-admselect-t,ads-revnetbid&ids=ahie2w,ahkqww,avcpf2,ahi4oc,ahkpar,a24lzr,ahkaa2,ahjo52,ahk9xm,ahgr9c,ahkucw,a6qja2,aopnp2,a9j7bh,ahh3cw,ahj63m,ahh9sm,ahk9p2,c53u52,ahjr5r,ahi2sm,bgvgqh,ahh49c,ahkqfr,ahhx2w,ahjojc,ahgyzr,ahi877,ahi8u2,aa89a2,a3oxnm,a33k6h,afx2kr,aecfh7,adfh77,ah7etc,ale3jc,apnmnm,ahi16h,ahi8zr,ahjg7w,ahjrvh,ahid9c,ahj9zr,ahkftc,ahklp2,ahh4nm,ahjq9c,ahhqur,ahju6h,c45mcw,ahiiec,ahhskr,c2u427,ahj4jc,ahkjtc,ahidf2,ahis1h,ahguoc,azhlcw,ahh7cw,ahhwkr,ahk7tc,ahit9c,ahhtk2,ahjryc,bqw7kr,b9filh,ahjahw,ahj72w,bov6ur,ahi6bh,ahh55r,c3wobh,ahitw7,ahhbfr,ahigu2,ahiszr,c5cptc,ahj5oc,ahiyk2,ahkkh7,ahhegh,ahjmqh,ahik1h,ahhhbh,c35okr,ahjxcw,ahjrbh,ahjuhw,c4ar4c,c1c3rw,aznblh,ahhru2,ahhra2,axwldm,b1lh9c,c4udpr,ahiooc,ahizur,ay3wim,ahgvz2,ahkeww,c2r1dm,ahkhur,b1lhz2,bwjg3m,axce4c,ahgtdm,ahixhw,ahhrcw,ahj7yc,ahitkr,azpom7,bqhbzr,c32pnm,b1hr27,ahgy77,ahkdur,ahjpr7,bgvm52&wrapodata=false"

payload={}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)