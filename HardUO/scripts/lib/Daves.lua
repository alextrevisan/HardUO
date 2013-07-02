------------------------------------------------------------------------------- 
-- Daves.lua
-- @author dwalker0229
-- @version 1.2
-- @client-compat 7.0.16.0 
-- @shard-compat OSI
-- @revised 7/22/2011 
-- @released 6/29/2011
-- @description multiple 
--		Daves Lib
--		dofile(getinstalldir().."scripts\\lib\\Daves.lua")
-- @dependencies 
--[[ Author: Cheffe]]	dofile(getinstalldir().."scripts\\lib\\Class.lua")
--[[ Author: Stuby085 Version: 1.0]]	dofile(getinstalldir().."scripts\\lib\\Container.txt")
--[[ Author: Kal In Ex Version: 1.1]] craftinfo=dofile(getinstalldir().."scripts\\lib\\CraftInfo.lua")
--[[ Author: Wesley Vanderzalm]]	dofile(getinstalldir().."scripts\\lib\\crafting.lua")
--[[ Author: Stuby085 Version: 1.0]]	dofile(getinstalldir().."scripts\\lib\\DateTime.txt")
--[[ Author: JosephAJ Version: V4.2]] dofile(getinstalldir().."/scripts/lib/ens_subs_buffdebuffbar.txt")
--[[ Author: Cheffe]]	dofile(getinstalldir().."scripts\\lib\\FileAccess.lua")
--[[ Author: Kal In Ex Version: 1.5]]	dofile(getinstalldir().."scripts\\lib\\FindConts.lua")
--[[ Author: Kal In Ex Version: 2.5]]	dofile(getinstalldir().."scripts\\lib\\FindItems.lua")
--[[ Author: Kal In Ex Version: 1.1]]	dofile(getinstalldir().."scripts\\lib\\journal.lua")
--[[ Author: Stuby085 Version: 1.0]]	dofile(getinstalldir().."scripts\\lib\\Journal.txt")
--[[ Author: Kal In Ex Version: 6.2]]	dofile(getinstalldir().."scripts\\lib\\KalOCR.lua")
--[[ Author: Wesley Vanderzalm]]	dofile(getinstalldir().."scripts\\lib\\mulhandles.lua")
--[[ Author: Wesley Vanderzalm]]	dofile(getinstalldir().."scripts\\lib\\pathfinder.lua")
--[[ Author: Wesley Vanderzalm Version: 1.0]]	dofile(getinstalldir().."scripts\\lib\\runebook.lua")
--[[ Author: Stuby085 Version: 1.0]]	dofile(getinstalldir().."scripts\\lib\\RuneBook.txt")
--[[ Author: unknown]]	slib=dofile(getinstalldir().."scripts\\lib\\simplelib.lua")
--[[ Author: unknown]]	dofile(getinstalldir().."scripts\\lib\\std.lua")
--[[ Author: Wesley Vanderzalm]]	dofile(getinstalldir().."scripts\\lib\\tile.lua")
-------------------------------------------------------------------------------
--http://www.easyuo.com/forum/viewtopic.php?t=46948
-------------------------------------------------------------------------------
--Common Variables
	accountsettingsfile="AccountSettings.txt"
	getblacksmithbods=true
	gettailorbods=false
	HoursBetweenGettingBods=1
	bodstxt="bods.txt"
	housebookname=string.lower("house")
	houserune1name=string.lower("house a")
	houserune2name=string.lower("house b")
	bodsmovetospot={[1]="2604_152",[2]="2604_148",[3]="2604_142", [4]="2604_139", [5]="2610_133", [6]="2610_132", [7]="2155_758", [8]="2147_758"}
	blacksmithrune1name=string.lower("blacksmith a")
	blacksmithrune2name=string.lower("blacksmith b")
	blacksmithmovetospot={[1]="1985_1366",[2]="1984_1365"}
	tailorrune1name=string.lower("tailor a")
	tailorrune2name=string.lower("tailor b")
	tailormovetospot={[1]="2079_1326"}
	bankrune1name=string.lower("bank a")
	bankrune2name=string.lower("bank b")
	bankmovetospot={[1]="5269_3992",[2]="5269_3988"}
	vendorbookname=string.lower("vendor")
	materialschestid=1120382675
	junkchestids={[1]=1108860352,[2]=1108860410}
	filledchestids={[1]=1108860390,[2]=1108860309}
	sortchests={[1]=1108860294,[2]=1126988811}
	pofchests={[1]=1078317094,[2]=1078317118}
	hammchests={[1]=1078317056}
	shovelchests={[1]=1127007900,[2]=1108860330}
	jewelchest=1111874559 
	tmapchest=1110578037
	soschest=1129050445
	netchest={1129050384}
	mainchest=1129050310
	keybag=1134397097
	keeperchest=1134325651
	percenttohealat=80
	junkbookname=string.lower("junksm")
	filledbookname=string.lower("filled")
	swapbookname=string.lower("swap")
	downxy="72_-15"	itemxy= "-60_-135"	acceptxy= "43_207"
	equipspellbookforrecall=true

-----------------------------------------------------gump sizes---------------------------------------------------------------
    gumps={		
		backpacksz	={name="container gump",szx=230,szy=204},
		bodbooksz	={name="generic gump",szx=0,szy=459},
		bodsz		={name="generic gump",szx=510,szy=0},
		healthbarsz	={name="status gump",szx=432,szy=184},
		loginsz		={name="Login gump",szx=640,szy=480},
		logoutsz	={name="YesNo gump",szx=178,szy=108},
		mainmenusz	={name="MainMenu gump",szx=640,szy=480},
		paperdollsz	={name="paperdoll gump",szx=262,szy=324},
		rewardsz	={name="generic gump",szx=510,szy=145},
		runebooksz	={name="generic gump",szx=452,szy=236},
		shardz		={name="normal gump",szx=640,szy=480},
		spellbooksz	={name="spellbook gump",szx=406,szy=249},
		spelliconsz	={name="spellicon gump",szx=48,szy=44},
		statussz	={name="status gump",szx=432,szy=184},
		tinksz		={name="generic gump",szx=530,szy=497},
		tofelsz		={name="generic gump",szx=420,szy=280},
		tongsz		={name="generic gump",szx=530,szy=497},
		waitingsz	={name="waiting gump",szx=408,szy=288}
		}
-----------------------------------------------------wait times---------------------------------------------------------------
	tick=15	onesecond=960*1	twosecond=960*2		threesecond=960*3	foursecond=960*4	fivesecond=960*5	sixsecond=960*6
	sevensecond=960*7		eightsecond=960*8	ninesecond=960*9	tensecond=960*10	elevensecond=960*10	halfsecond=960/2	
	onehalfsecond=960/2+960 thirdsecond=960/3	tenthsecond=960/10
    -----------------------------------------------------colors---------------------------------------------------------------
	plainhammcolor=0					ancienthammcolor=1154
	smithbodcolor=1105					tailbodcolor=1155
	ircolor=0							dccolor=2419						shcolor=2406					cocolor=2413	
	brcolor=2418						gocolor=2213						agcolor=2425					vecolor=2207	
	vacolor=2219
    -----------------------------------------------------obj types---------------------------------------------------------------
	axetypes={3913,3911,3915,3909,5115,5187,5040,3907}

	barreltype=3703	batype=12697	bdtype=12696	blackrocktype={3880,3878,3883,3882}	bodbooktype=8793	bodtype=8792
	bonepiletype={6924,6925,6926,6921,6922,6927,6923,6928,6940,6939,6933,6934,6938,6937,6929,6930,6931,6932,6935,6936}
	bonetype=3966	

	chesttype={3650,3649,3648,2475,3651}	comdeed=5360	corpsetype=8198

	daggertype=3921	delicatescales=22330	dstype=12690	

	ectype=12693	elftype={605,606}	enemytype={150,16,77,317}	

	firebeetletype=169	fishpoletype={3519,3520}	fishsteaktype=2426	foodtype={2487,2515,2545,2496,5642}	forgetype=4017
	frtype=12695

	garbagetype={3717,3718,4020}	gloves={5077}	goldtype=3821	greenfish=2508	greyfish=2509	

	hammtype=5091	hidetype=4216	holdeasttype=15973	holdnorthtype=16046	holdsouthtype=16057	holdwesttype=16019	humantype={401,400}

	ingottype=7154 ingotcol={ir=0,dc=2419,sh=2406,co=2413,br=2418,go=2213,ag=2425,ve=2207,va=2219}

	jewelingtype={7154,12692,12691,12696,12695,12697,12693,12690}	jewelrytype={7942,7945,4234,4230}	jeweltype={12692,12691,12696,12695,12697,12693,12690}

	keytype={4110,4111,4112,4115}	krakentype=77	

	leathertype=4225	lockpicktype=5371

	maptype={5355,5356} 	mibtype=2463	musicinsttype=3762	

	nettype=3530	nontinyoretype={6585,6584,6586}

	orangefish=2511	oretype={6585,6584,6586,6583}

	packytypes={}	paintingtype={3785,3749,3750,3752,3748,3743,3747,3744}	petaltype=4129	--[[petal Col{orange=43 purple=}]]	petype=12692	
	pickaxestype={3717,3718}	pillowtype={5031,5030,5029,5038,5032,5028,5036,5035,5033,5037,5034}	poftype=4102	prospectortype=4020	purplefish=2510

	rope={5370,5368}	runebooktype=8901

	scaletype={9908,2545}	scissortype=3998	serptype=150	shelltype={4044,4037,4039,4036,4042,4043,4038,4040,4041}
	shipwrecktype={2599,4168,5915,7858,7861,7859,7860,4167,7397,7857,3542,6880,6882,7394,6883,3103,7404,7401,6884,6881,7392,5443,7389,5444,7393,2602}
	shoetype={5906,5904,5901,5900,5903,5902,5905,5899}	shoveltype={3898,3897}	smithtooltypes={4028,5091}	sostype=5358
	specialfishtype=3542	spellbooktype=3834

	teleporttiletype=16571	tillermantype={15947,15950,15952,15957}	tinkertooltype={7865,7868,7864}	tinyoretype={6583}
	tillermanfacingwest=15952 tillermanfacingnorth=15950 tillermanfacingeast=15957 tillermanfacingsouth=15947
	tongstype=4028	tutype=12691

	vendortype={400,401,605,606}

	waterelletype=16	whitpearltype=12694 woodlogtype=7133 woodboardtype=7127

	initcount={iron=0,dull=0,shad=0,copp=0,bron=0,gold=0,agap=0,veri=0,valo=0,pe=0,tu=0,bd=0,fr=0,ba=0,ec=0,ds=0}
	currcount={iron=0,dull=0,shad=0,copp=0,bron=0,gold=0,agap=0,veri=0,valo=0,pe=0,tu=0,bd=0,fr=0,ba=0,ec=0,ds=0}
	totcount={iron=0,dull=0,shad=0,copp=0,bron=0,gold=0,agap=0,veri=0,valo=0,pe=0,tu=0,bd=0,fr=0,ba=0,ec=0,ds=0}

	
	digabletype={220,221,222,223,224,225,226,227,228,229,230,231,236,237,238,239,
		240,241,242,243,244,245,246,247,252,253,254,255,256,257,258,259,260,
		261,262,263,268,269,270,271,272,273,274,275,276,277,278,279,286,287,
		288,289,290,291,292,293,294,296,296,297,321,322,323,324,467,468,469,
		470,471,472,473,474,476,477,478,479,480,481,482,483,484,485,486,487,
		492,493,494,495,543,544,545,546,547,548,549,550,551,552,553,554,555,
		556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,
		573,574,575,576,577,578,579,581,582,583,584,585,586,587,588,589,590,
		591,592,593,594,595,596,597,598,599,600,601,610,611,612,613,1010,1741,
		1742,1743,1744,1745,1746,1747,1748,1749,1750,1751,1752,1753,1754,1755,
		1756,1757,1771,1772,1773,1774,1775,1776,1777,1778,1779,1780,1781,1782,
		1783,1784,1785,1786,1787,1788,1789,1790,1801,1802,1803,1804,1805,1806,
		1807,1808,1809,1811,1812,1813,1814,1815,1816,1817,1818,1819,1820,1821,
		1822,1823,1824,1831,1832,1833,1834,1835,1836,1837,1838,1839,1840,1841,
		1842,1843,1844,1845,1846,1847,1848,1849,1850,1851,1852,1853,1854,1861,
		1862,1863,1864,1865,1866,1867,1868,1869,1870,1871,1872,1873,1874,1875,
		1876,1877,1878,1879,1880,1881,1882,1883,1884,1981,1982,1983,1984,1985,
		1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,
		2000,2001,2002,2003,2004,2028,2029,2030,2031,2032,2033,2100,2101,2102,
		2103,2104,2105,1339,1340,1341,1342,1343,1344,1345,1346,1347,1348,1349,
		1350,1351,1352,1353,1354,1355,1356,1357,1358,1359}
	doortype={233,235,237,239,241,243,245,247,556,557,558,559,789,791,793,795,
		797,799,801,803,805,807,809,811,813,815,817,819,821,823,825,827,829,
		831,833,835,837,839,841,843,845,847,849,851,853,855,857,859,861,863,
		865,867,1653,1654,1655,1656,1657,1658,1659,1660,1661,1662,1663,1664,
		1665,1666,1667,1668,1669,1670,1671,1672,1673,1674,1675,1676,1677,1678,
		1679,1680,1681,1682,1683,1684,1685,1686,1687,1688,1689,1690,1691,1692,
		1693,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703,1704,1705,1706,
		1707,1708,1709,1710,1711,1712,1713,1714,1715,1716,1717,1718,1719,1720,
		1721,1722,1723,1724,1725,1726,1727,1728,1729,1730,1731,1732,1733,1734,
		1735,1736,1737,1738,1739,1740,1741,1742,1743,1744,1745,1746,1747,1748,
		1749,1750,1751,1752,1753,1754,1755,1756,1757,1758,1759,1760,1761,1762,
		1763,1764,1765,1766,1767,1768,1769,1770,1771,1772,1773,1774,1775,1776,
		1777,1778,1779,1780,6514,6515,7897,7898,7899,7900,7901,7902,7903,7904,
		7905,7906,7907,7908,7909,7910,7911,7912,7913,7914,7915,7916,7917,7918,
		7919,7920,7921,7922,7923,7924,7925,7926,7927,7928,7929,7930,7931,7932,
		8173,8174,8175,8176,8177,8178,8179,8180,8181,8182,8183,8184,8185,8186,
		8187,8188,9247,9248,9249,9250,9251,9252,9972,9974,10640,10641,10654,
		10655,10757,10758,10759,10760,10761,10762,10763,10764,10765,10766,10767,
		10768,10769,10770,10771,10772,10773,10774,10775,10776,10777,10778,10779,
		10780,11590,11591,11592,11593,11619,11620,11621,11622,11623,11624,11625,
		11626,11627,11628,11629,11630,12258,12259,12260,12261}
	scrolltype={8816,8008,8011,8010,8021,8020,8023,8022,8017,08016,8019,8018,
			 8029,8028,8031,8030,8025,8024,8027,8026,8037,8036,8039,8038,
			 8033,8032,8035,8034,8040,8041,8042,8043,8044,8005,8004,8007,
			 8006,8001,8000,8003,8002,8013,8012,8015,8014,8009,7982,7983,
			 7985,7981,7988,7989,7990,7991,6173,7987,7986,7997,7996,07999,
			 7998,7993,7992,7995,7994,8806,8813,8814,8809,8810,8808,11602,
			 11605,11611,11604,11613,11609,11612,11606,011616,11610,11614,
			 11601,11615,11603}
	
	trashtype={5031,5030,5029,5038,5032,5028,5036,5035,5033,5037,5034,4044,4037,4039,
			4036,4042,4043,4038,4040,4041,3785,3749,3750,3752,3748,3743,3747,3744,
			2599,4168,5915,7858,7861,7859,7860,4167,7397,7857,3542,6880,6882,7394,
			6883,3103,7404,7401,6884,6881,7392,5443,7389,5444,7393,2602,5906,5904,
			5901,5900,5903,5902,5905,5899}
	loottype={3530,2463,5358,5355,5356,3821,3859,3878,3857,3862,3864,3855,3856,3877,
				   3861,3873,3865,3885,3962,3963,3972,3973,3974,3976,3981,3980,3965,3983,
				   3982,3978,3960,8816,8008,8011,8010,8021,8020,8023,8022,8017,8016,8019,
				   8018,8029,8028,8031,8030,8025,8024,8027,8026,8037,8036,8039,8038,8033,
				   8032,8035,8034,8040,8041,8042,8043,8044,8005,8004,8007,8006,8001,8000,
				   8003,8002,8013,8012,8015,8014,8009,7982,7983,7985,7981,7988,7989,7990,
				   7991,6173,7987,7986,7997,7996,7999,7998,7993,7992,7995,7994,8806,8813,
				   8814,8809,8810,8808,11602,11605,11611,11604,11613,11609,11612,11606,
				   11616,11610,11614,11601,11615,11603,22330,4216,9908,2545,4225}
	regtype={3962,3963,3972,3973,3974,3976,3981,3980,3965,3983,3982,3978,3960}
	gemtype={3859,3878,3857,3862,3864,3855,3856,3877,3861,3873,3865,3885}
	fishtype={2511,2508,2510,2509}
	holdtype={16046,16019,16057,15973}
    -----------------------------------------------------prevent hangups---------------------------------------------------------------
	houserune={}	blacksmithrune={}	tailorrune={}	bankrune={}	currcount={}	initcount={}	totcount={}	serpcorpse={}
	initingcount=true
    -----------------------------------------------------ids---------------------------------------------------------------
	charid=UO.CharID	initstr=UO.Str	initdex=UO.Dex	initint=UO.Int	inithits=UO.Hits	initmaxhits=UO.MaxHits	
	initstamina=UO.Stamina	initmaxstamina=UO.MaxStam	initmana=UO.Mana	initmaxmana=UO.MaxMana
	initweight=UO.Weight	initmaxweight=UO.MaxWeight	initar=UO.AR	initfr=UO.FR	initcr=UO.CR	initpr=UO.PR	initer=UO.ER	inittp=UO.TP
	backpack=UO.BackpackID	clientversion=UO.CliVer	title=UO.CliTitle
-------------------------------------------------------------------------------
function analyze(rx,ry,resource) --				tSpotn=analyze(CharPosX,CharPosY,resource) resource="tree" or "ore"
	verbose2("analyze",rx,ry,resource)
	lookx=rx-2
	looky=ry-2
	divx=0
	divy=0
	look={}
	look["quads"]=0
	for tx=lookx,lookx+4 do
		cx=(8 * (math.floor(tx / 8)))
		if cx==tx then
			divx=cx
			break
		end
	end
	for ty=looky,looky+4 do
		cy=(8 * (math.floor(ty / 8)))
		if cy==ty then
			divy=cy
			break
		end
	end
	print(divx)
	print(divy)
	num=0
	if divx==0 and divy==0 then
		look["quads"]=1
		for ty=looky,looky+4 do
			for tx=lookx,lookx+4 do
				num=num+1
				look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=1}
			end
		end
	end
	if divx~=0 and divy==0 then
		look["quads"]=2
		for ty=looky,looky+4 do
			for tx=lookx,lookx+4 do
				num=num+1
				if tx < divx then
					look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=1}
				else
					look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=2}
				end
			end
		end
	end
	if divx==0 and divy~=0 then
		look["quads"]=2
		for ty=looky,looky+4 do
			for tx=lookx,lookx+4 do
				num=num+1
				if ty < divy then
					look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=1}
				else
					look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=2}
				end
			end
		end
	end
	if divx~=0 and divy~=0 then
		look["quads"]=4
		for ty=looky,looky+4 do
			for tx=lookx,lookx+4 do
				num=num+1
				if ty < divy then
					if tx < divx then
						look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=1}
					else
						look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=2}
					end
				else
					if tx < divx then
						look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=3}
					else
						look[num] = {["spot"]=num, ["x"]=tx, ["y"]=ty, ["quad"]=4}
					end
				end
			end
		end
	end
	local bsuccess = UO.TileInit()
	quads=look["quads"]
	if quads>0 then
        spotn={}
		spotcnt=0
		for quad=1,quads do
		br=false
			for spot=1,25 do
				if look[spot]["quad"]==quad then
					digxx=look[spot]["x"]
					digyy=look[spot]["y"]
					nCnt=UO.TileCnt(digxx,digyy,UO.CursKind)
					for i=nCnt,1,-1 do
					    nType,nZ,sName,nFlags=UO.TileGet(digxx,digyy,i,UO.CursKind)
						if resource=="ore" then
							for w=1,#digabletype do 
								if nType == digabletype[w] and nZ>UO.CharPosZ-4 and nZ<UO.CharPosZ+4 then 
									spotcnt=spotcnt+1 
									spotn[spotcnt]={["X"]=digxx,["Y"]=digyy,["Z"]=nZ,["Type"]=nType,["quad"]=quad}
									br=true
								end 
							end
						end
						if resource=="tree" then
							if "tree"==string.match(sName,"tree") then 
								spotcnt=spotcnt+1 
								spotn[spotcnt]={["X"]=digxx,["Y"]=digyy,["Z"]=nZ,["Type"]=nType,["quad"]=quad}
								br=true
							end 
						end
						if br==true then break end
					end
				end
			if br==true then break end
			end
		end
	end
	spotn["cnt"]=spotcnt
	return spotn
end
-------------------------------------------------------------------------------
function buyitemsfrom(vendorid,itemtype,count)--bSuccess=buyitemsfrom(vendor,itemtype,count)
	temp=split(downxy,"_")
	downx=tonumber(temp[1]) downy=tonumber(temp[2])
	temp=split(itemxy,"_")
	itemx=tonumber(temp[1]) itemy=tonumber(temp[2])
	temp=split(acceptxy,"_")
	acceptx=tonumber(temp[1]) accepty=tonumber(temp[2])
	verbose2("buyitemsfrom",vendorid,itemtype,count)
	if type(count)==string then count=9999 end
	UO.Popup(vendorid,0,20)
	wait(onesecond)
	clickxxyy(24,57) wait(tenthsecond)
	wait(onesecond)
	repeat
		bRes,nPos,nCnt,nID,nType,nMax,nPrice,sName = UO.GetShop() 
		baught=false
		if itemtype==nType then
			clickxxyy(itemx,itemy)
			clickxxyy(itemx,itemy)
			wait(tenthsecond)
			wait(tenthsecond)
			clickxxyy(itemx+1,itemy+1)
			clickxxyy(itemx+1,itemy+1)
			wait(tenthsecond)
			wait(tenthsecond)
			clickxxyy(itemx+2,itemy+2)
			clickxxyy(itemx+2,itemy+2)
			wait(tenthsecond)
			wait(tenthsecond)
			num=nMax-0
			local bres = UO.SetShop(nID,count)
			clickxxyy(acceptx,accepty)
			wait(tenthsecond)
			baught=true
			if contsz(283,248,false) then
				break
			end
		else
			if olditem == nID then
				clickxxyy(acceptx,accepty)
				baught=true
			end
			if contsz(283,248,false) then
				break
			end
			olditem=nID
			if contsz(283,248,false) then
				break
			end
			clickxxyy(downx,downy)
			wait(tenthsecond)
		end
	until baught==true
	return true
end
-------------------------------------------------------------------------------
function checkhealth(percenttohealat,method) --	checkhealth(80,"magery")
	--verbose2("checkhealth",percenttohealat,method)
	if UO.MaxHits==0 then UO.Macro(8,2) wait(onesecond) end
	healat=UO.MaxHits * percenttohealat / 100
	if method=="greater heal" or method=="magery" then
		repeat
			status=string.lower(UO.CharStatus)
			if "C"==string.match(status, "C") then
				repeat
					if UO.MaxHits==0 then UO.Macro(8,2) wait(onesecond) end
					if UO.Mana<6 then meditate(7) end
					UO.Macro(15,24)
					targetitem("self")
					wait(onesecond)
					status=string.lower(UO.CharStatus)
				until "C"~=string.match(status, "C")
			end
			if UO.Hits < healat then
				if UO.MaxHits==0 then UO.Macro(8,2) wait(onesecond) end
				if UO.Mana<11 then meditate(12) end
				UO.Macro(15,28)
				targetitem("self")
				wait(onesecond)
			end
			status=string.lower(UO.CharStatus)
		until "C"~=string.match(status, "C") and UO.Hits>healat
	end
	if method=="bandage" or method=="healing" then
		repeat
			status=string.lower(UO.CharStatus)
			if "C"==string.match(status, "C") then
			end
			if UO.Hits < healat then
			end
			status=string.lower(UO.CharStatus)
		until "C"~=string.match(status, "C") and UO.Hits>healat
	end
end
-------------------------------------------------------------------------------
function checkstringfor(strings,find)
	ab=string.lower(strings) ac=string.lower(find)
	if ac==string.match(ab, ac) then return true else return false end
end
-------------------------------------------------------------------------------
function clickmakeexit() --						clickmakeexit()
	verbose2("clickmakeexit")
	clickxxyy(28,454) wait(tenthsecond)
end
-------------------------------------------------------------------------------
function clickmakelast(tool) --					clickmakelast("tink")	clickmakelast("tong")
	verbose2("clickmakelast",tool)
	timex=getticks() + 4000
	bkind=clickxxyy(284,451,true) if bkind==false then usetool(tool) end
end
-------------------------------------------------------------------------------
function clickxxyy(cx,cy, ... ) --				clickxxyy(x,y) or clickxxyy(x,y,bKindwait) or clickxxyy(x,y,bool,bool,bool,bool) or clickxxyy(x,y,bKindwait,bool,bool,bool,bool)
	if #arg==0 or #arg==1 then
		aaa=true
		bbb=true
		ccc=true
		ddd=false
	end
    if #arg==4 or #arg==5 then
		aaa=arg[1]
		bbb=arg[2]
		ccc=arg[3]
		ddd=arg[4]
	end
	ax=UO.ContPosX + cx
	ay=UO.ContPosY + cy
	if #arg==1 and arg[1]==true or #arg == 5 and arg[1]==true then 
		trackkind=UO.ContKind
		timex=getticks() + 4000
		verbose2("clickxxyy",arg)
		UO.Click(ax,ay,aaa,bbb,ccc,ddd)
		repeat 
			wait(tick) 
			if UO.ContKind==trackkind then return true end
			if timex < getticks() then return false end
		until UO.ContKind==trackkind or timex < getticks()
		return false
	else
		UO.Click(ax,ay,aaa,bbb,ccc,ddd)
	end
	return true
end
-------------------------------------------------------------------------------
function clientsetup( ... ) --						clientsetup()
	verbose2("clientsetup")
	if #arg>0 then UO.CliXRes=arg[1] UO.CliYRes=arg[1] * 75 / 100 end
	UO.Macro(31,0) wait(thirdsecond)
	UO.CliLeft=0 UO.CliTop=0 wait(tenthsecond) 
	while UO.ContName~="paperdoll gump" do UO.Macro(8,1) wait(onesecond) end UO.ContPosX=500 UO.ContPosY=0 wait(tenthsecond) 
	while UO.ContName~="status gump" do UO.Macro(8,2) wait(onesecond) end UO.ContPosX=100 UO.ContPosY=340 wait(tenthsecond) 
	while UO.ContName~="container gump" do UO.Macro(8,7) wait(onesecond) end UO.ContPosX=475 UO.ContPosY=310 wait(tenthsecond) 
end
-------------------------------------------------------------------------------
function combine(combineitype,combinecurrentbod)
	if verbose then print("combine" .." " ..combineitype .." " ..combinecurrentbod) end
	repeat
		repeat useobject(combinecurrentbod)
		until UO.ContName=="generic gump" and UO.ContSizeX==510
		exityy=UO.ContSizeY-27
		combineyy=UO.ContSizeY-51
		clickxxyy(140,combineyy)
		timex=getticks() + foursecond
		repeat wait(tick) 
		until UO.TargCurs==true or timex < getticks()
		combinetemp=ScanItems(true,{Type=combineitype,ContID=backpack})
		for combinetempindex=1,#combinetemp do
			currentcombinetemp=combinetemp[combinetempindex].ID
			targetitem(currentcombinetemp)
			timex=getticks() + 2000
			repeat wait(tick) 
			until UO.TargCurs==true or combinetempindex==#combinetemp or timex<getticks()
		end
		combinetemp=ScanItems(true,{Type=combineitype,ContID=backpack})
	until #combinetemp==0
	if UO.ContSizeX==510 then
		clickxxyy(140,exityy)
		timex=getticks() + foursecond
		repeat wait(tick) 
		until UO.ContSizeX~=510 or timex < getticks()
	end
	UO.TargCurs=false
	wait(onesecond)
end
-------------------------------------------------------------------------------
function contsz(contx,conty,bbool) --			bool=contsz(contx,conty,bbool)
	verbose2("contsz",contx,conty,bbool)
	if bbool==true then
		if UO.ContSizeX==contx and UO.ContSizeY==conty then return true end
	end
	if bbool==false then
		if UO.ContSizeX~=contx and UO.ContSizeY~=conty then return true end
	end
	return false
end
-------------------------------------------------------------------------------
function countpieces(itype,quality)
if verbose then print("countpieces " ..itype .." " ..quality) end
	repeat
		smelted=false
		countpiecestemp=ScanItems(true,{Type=itype,ContID=backpack})
		countpiecestot=#countpiecestemp
		for countpiecesindex=1,#countpiecestemp do
			currentcountpiecesid=countpiecestemp[countpiecesindex].ID
			if quality=="Exceptional" then
				countpiecesname,countpiecesinfo=UO.Property(currentcountpiecesid)
				if quality~=string.match(countpiecesinfo, quality) then
					smeltitem(currentcountpiecesid)
					smelted=true
				end
			end
		end
	until smelted==false
	return tonumber(countpiecestot)
end
-------------------------------------------------------------------------------
function debug2( ... ) --						debug2(a,b,c,d,e,f,g, ...) 
	if verbose==true then
		debugtext="debug2 "
		for argi=1,#arg do
			if type(arg[argi])~="table" then
				debugtext=debugtext .. tostring(arg[argi]) .. "|"
			else
				debugtext=debugtext .. TableToString(arg[argi]) .. "|"
			end
		end
		print(debugtext) pause() 
	end
end
-------------------------------------------------------------------------------
function determinecolor(material)
	if verbose then print("determinecolor " ..material) end
	materialsplit=split(material," ")
	material=materialsplit[1]
	if material=="Iron" then col=0 end
	if material=="Dull" then col=2419 end
	if material=="Shadow" then col=2406 end 
	if material=="Copper" then col=2413 end
	if material=="Bronze" then col=2418 end
	if material=="Gold" then col=2213 end
	if material=="Agapite" then col=2425 end
	if material=="Verite" then col=2207 end
	if material=="Valorite" then col=2219 end 
	if verbose then print("determinecolor " ..material .." " ..col) end
	return col
end
-------------------------------------------------------------------------------
function Drag(what,from,to) --					Drag(what,from,to)
	verbose2("Drag",what,from,to)
	UO.Drag(what) 
	wait(halfsecond)
	UO.DropC(to) 
	wait(onesecond)
end
-------------------------------------------------------------------------------
			function Drag2(item,to, ... ) --      						Not working yet --		Drag2( ... )
	verbose2("Drag2",arg[1])
	if #arg==0 then
		UO.Drag(item) wait(halfsecond)
		UO.DropC(to) wait(onesecond)
		return
	end
	if #arg>0 then
		
	
	end

	if #arg==2 then
		if verbose then print("Drag" .."|" ..arg[1] .."|" ..arg[2]) end
		drags=ScanItems(true,{Type=arg[1]})
		if #drags>0 then
			UO.Drag(ags[1]) wait(halfsecond)
			UO.DropC(arg[2]) wait(onesecond)
		end
		drags2=ScanItems(true,{ID=drags[1].ID,ContID=to})
		if #drags2>0 then return true else return false end
	end
	if #arg==3 then
		if verbose then print("Drag" .."|" ..arg[1] .."|" ..arg[2] .."|" ..arg[3]) end
		drags=ScanItems(true,{Type=what,ContID=from})
		if #drags>0 then
			UO.Drag(drags[1].ID) wait(halfsecond)
			UO.DropC(to) wait(onesecond)
		end
		drags2=ScanItems(true,{ID=drags[1].ID,ContID=to})
		if #drags2>0 then return true else return false end
	end
	if #arg==4 then
		if verbose then print("Drag" .."|" ..arg[1] .."|" ..arg[2] .."|" ..arg[3] .."|" ..arg[4]) end
		drags=ScanItems(true,{Type=what,ContID=from})
		if #drags>0 then
			UO.Drag(drags[1].ID) wait(halfsecond)
			UO.DropC(to) wait(onesecond)
		end
		drags2=ScanItems(true,{Type=what,ContID=to})
		if #drags2>0 then return true else return false end
	end
end
-------------------------------------------------------------------------------
function droptoground(item) --					droptoground(item or itemtype) --if overweight use this to drop to a random location
	verbose2("droptoground",item)
    item=tostring(item)
    leng=string.len(item)
    item=tonumber(item)
    if leng > 6 then
        items=ScanItems(true,{ID=item,ContID=UO.BackpackID})
        if #items < 1 then return end
        itemid=items[1].ID
        itemtype=items[1].Type
        itemcol=items[1].Col
		itemstack=items[1].Stack
        itemsonground=ScanItems(true,{Type=itemtype,Col=itemcol},{ContID=UO.BackpackID})
        if #itemsonground < 1 then 
            repeat
                randx=math.random(1,5)
                randy=math.random(1,5)
                if randx==UO.CharPosX and randy==UO.CharPosY then contin=false end
				dropx=UO.CharPosX - 3 + randx
				dropy=UO.CharPosY - 3 + randy
				UO.Drag(itemid,itemstack) wait(halfsecond)
				UO.DropG(dropx,dropy) wait(onesecond)
				itemsonground=ScanItems(true,{ID=itemid},{ContID=UO.BackpackID})
            until #itemsonground>0
        else
            xx=itemsonground[1].X
            yy=itemsonground[1].Y
            finddist(xx,yy)
            if dx < 3 and dy < 3 then
                to=itemsonground[1].ID
                UO.Drag(itemid,itemstack) wait(halfsecond)
                UO.DropC(to) wait(onesecond)
            end
        end
    else
        items=ScanItems(true,{Type=item,ContID=UO.BackpackID})
        if #items < 1 then return end
        itemid=items[1].ID
        itemtype=items[1].Type
        itemcol=items[1].Col
 		itemstack=items[1].Stack
		itemsonground=ScanItems(true,{Type=itemtype,Col=itemcol},{ContID=UO.BackpackID})
        if #itemsonground < 1 then 
            repeat
                contin=true
                randx=math.random(1,5)
                randy=math.random(1,5)
                if randx==UO.CharPosX and randy==UO.CharPosY then contin=false end
				dropx=UO.CharPosX - 3 + randx
				dropy=UO.CharPosY - 3 + randy
				UO.Drag(itemid,itemstack) wait(halfsecond)
				UO.DropG(dropx,dropy) wait(onesecond)
				itemsonground=ScanItems(true,{ID=itemid},{ContID=UO.BackpackID})
            until #itemsonground>0
        else
            xx=itemsonground[1].X
            yy=itemsonground[1].Y
            finddist(xx,yy)
            if dx < 3 and dy < 3 then
                to=itemsonground[1].ID
                UO.Drag(itemid,itemstack) wait(halfsecond)
                UO.DropC(to) wait(onesecond)
            end
        end
    end
end
-------------------------------------------------------------------------------
function easy2open(easyID) -- 					From EasyUO to OpenEUO
	verbose2("easy2open",easyID)
	easyID = string.upper(easyID) 
   local i, j, openID = 1, 0, 0  
    
   for j = 1, #easyID do 
      local char = easyID:sub(j,j) 
      openID = openID + ( string.byte(char) - string.byte('A') ) * i 
      i = i * 26 
   end 
   openID = Bit.Xor((openID - 7), 69) 
   return openID 
end 
-------------------------------------------------------------------------------
function equiptype(typeorid,equipment) --		itemid=equiptype(typeorid,equipment) --type or id
	repeat
		equipped=false
		if string.lower(typeorid)=="type" then t=ScanItems(true,{Type=equipment}) end
		if string.lower(typeorid)=="id" then t=ScanItems(true,{ID=equipment}) end
		for ind=#t,0, -1 do
			if t[ind].ContID==UO.BackpackID then
				equipmentid=t[ind].ID
				UO.Equip(equipmentid)
				if debug then print("equipment " ..equipmentid .." equipped") end wait(onesecond)
				return equipmentid
			end
			if t[ind].ContID==UO.CharID then
				equipmentid=t[ind].ID
				if debug then print("equipment " ..equipmentid .." already equipped") end wait(onesecond)
				return equipmentid
			end
		end
	until equipped==true
end
-------------------------------------------------------------------------------
function estr2open(str) -- 						OpenEUOTable=estr2open("EUO_STRING")
	verbose2("estr2open",str)
	--[[
dofile(getinstalldir().."scripts/lib/Daves.lua")
a="POF"
b=estr2open(a)
print(TableToString(b))
]]
   local easyIDs = {} 
   local openIDs = {} 
    
   easyIDs = explode("_", str) 
   for k, easyID in pairs(easyIDs) do 
      table.insert(openIDs, easy2open(easyID)) 
   end 
   print(TableToString(openIDs))  
   return openIDs 
end 
-------------------------------------------------------------------------------
function explode(delimiter, str) -- 			String Explode for internal use 
	verbose2("explode",delimiter, str)
   local tbl, i, j 
   tbl={} 
   i=0 
   if(#str == 1) then return str end 
   while true do 
      j = string.find(str, delimiter, i+1, true) -- find the next d in the string 
      if (j ~= nil) then -- if "not not" found then.. 
         table.insert(tbl, string.sub(str, i, j-1)) -- Save it in our array. 
         i = j+1 -- save just after where we found it for searching next time. 
      else 
         table.insert(tbl, string.sub(str, i)) -- Save what's left in our array. 
         break -- Break at end, as it should be, according to the lua manual. 
      end 
   end 
   return tbl 
end 
-------------------------------------------------------------------------------
function extractbods(numberofbods,book) --		extractbods(numberofbods,bodbookid)
	verbose2("extractbods",numberofbods,book)
	pollbodbook(book)
	if count<1 then return end
	repeat  
		UO.LObjectID=book UO.Macro(17,0) wait(onesecond) 
	until waitforgump("bodbooksz",true)
	if UO.ContPosX<0 or UO.ContPosX>300 or UO.ContPosY<0 or UO.ContPosY>300 then UO.ContPosX=30 UO.ContPosY=30 end
	t=ScanItems(true,{Type=bodtype,ContID=backpack})
	--debug2(t)
	if #t<numberofbods then
		repeat
			if verbose then print("ExtractBods " ..#t .." of " ..numberofbods) end                
			ExtractBodsckind=UO.ContKind 
			clickxxyy(42,103)
			timex=getticks() + 2000 
			repeat 
			until ExtractBodsckind==UO.ContKind or timex < getticks() 
			t=ScanItems(true,{Type=bodtype})
		until timex < getticks() or #t>=numberofbods
	end
	repeat clickxxyy(389,427) wait(thirdsecond)
	until waitforgump("bodbooksz",false)
end
-------------------------------------------------------------------------------
function fillbodid(currentbodid) --				fillbodid(currentbodid)
			getbodammounts(currentbodid)
			currentbodname,currentbodinfo=UO.Property(currentbodid)
			print(currentbodname)
			print(currentbodinfo)
			size="" left="" quality="" material="" item="" cmenu=""
			if "Small"==string.match(currentbodinfo, "Small") then
				if "Small"==string.match(currentbodinfo, "Small") then size="Small"end
				if "Large"==string.match(currentbodinfo, "Large") then size="Large" end
				if "Normal"==string.match(currentbodinfo, "Normal") then quality="Normal" end
				if "Exceptional"==string.match(currentbodinfo, "Exceptional") then quality="Exceptional" end
				material="Iron Ingots" cmenu="1"
				if "Dull Copper Ingots"==string.match(currentbodinfo, "Dull Copper Ingots") then material="Dull" cmenu="2" end
				if "Shadow Iron Ingots"==string.match(currentbodinfo, "Shadow Iron Ingots") then material="Shadow" cmenu="3" end
				if "Copper Ingots"==string.match(currentbodinfo, "Copper Ingots") and "Dull"~=string.match(currentbodinfo, "Dull") then material="Copper" cmenu="4" end
				if "Bronze Ingots"==string.match(currentbodinfo, "Bronze Ingots") then material="Bronze" cmenu="5" end
				if "Gold Ingots"==string.match(currentbodinfo, "Gold Ingots") then material="Gold" cmenu="6" end
				if "Agapite Ingots"==string.match(currentbodinfo, "Agapite Ingots") then material="Agapite" cmenu="7" end
				if "Verite Ingots"==string.match(currentbodinfo, "Verite Ingots") then material="Verite" cmenu="8" end
				if "Valorite Ingots"==string.match(currentbodinfo, "Valorite Ingots") then material="Valorite" cmenu="9" end
				itemcaraftinfotwo=split(currentbodinfo, "\n")
				itemcaraftinfo=split(itemcaraftinfotwo[#itemcaraftinfotwo], '\\:')
				itemcaraftinfo=string.lower(itemcaraftinfo[1])
				itemcaraftinfo=tostring(itemcaraftinfo)
				asd=string.len(itemcaraftinfo)
		---Buckler causes an issue this next part covers that
				if " "==string.sub(itemcaraftinfo,asd) then
					asd=asd-1
					qwe=string.sub(itemcaraftinfo,1,asd)
					itemcaraftinfo=qwe
				end
		---platemail tunic causes an issue this next part covers that
				if itemcaraftinfo=="platemail tunic" then
					itemcaraftinfo="platemail \\(tunic\\)"
				end
		---female plate causes an issue this next part covers that
				if itemcaraftinfo=="female plate" then
					itemcaraftinfo="platemail \\(female\\)"
				end
				itemcaraftinfoinfo=craftinfo["blacksmithing"][itemcaraftinfo]
				print(TableToString(itemcaraftinfoinfo))
				menu=(itemcaraftinfoinfo["category"] .."_" ..itemcaraftinfoinfo["selection"])
				menu=tostring(menu)
				itype=itemcaraftinfoinfo["type"]
				ingotsneeded=itemcaraftinfoinfo["material"][1]["value"] 
				repeat
					currentbodneeded,currentbodcreated,currentbodleft=getbodammounts(currentbodid)
					countpieces(itype,quality)
					currentbodleft=currentbodneeded-currentbodcreated-countpiecestot
					if currentbodleft>0 then
						usetool("tong")
						setcolor(cmenu)
						--checkingots(material,ingotsneeded,currentbodleft)
						makeitem(currentbodid,itype,quality,menu,currentbodleft,itemcaraftinfo)
					end
					currentbodneeded,currentbodcreated,currentbodleft=getbodammounts(currentbodid)
					countpieces(itype,quality)
					currentbodleft=currentbodneeded-currentbodcreated-countpiecestot
				until currentbodleft<=countpiecestot
			end
			returningots(materialschestid)
			if tonumber(currentbodcreated)~=tonumber(currentbodneeded) then combine(itype,currentbodid) end
end
-------------------------------------------------------------------------------
function finddist(x,y) --						dist=finddist(x,y)
	--verbose2("finddist",x,y)
	dx=math.abs(UO.CharPosX - x) 
	dy=math.abs(UO.CharPosY - y) 
	return math.max(dx, dy) 
end
-------------------------------------------------------------------------------
function findtrash() --							trashid=findtrash()
	verbose2("findtrash")
	trash=0
	items=ScanItems(true,{Type=barreltype})
	if #items>0 then
		for itemsnum=1,#items do
			name,info=UO.Property(items[itemsnum].ID)
			if "Trash"==string.match(name, "Trash") then trashid=items[itemsnum].ID end
		end
	end
	return trashid
end
-------------------------------------------------------------------------------
function findvendor( ... ) --		   			vendorfound,vendorid=findvendor("blacksmith","armourer")
	verbose2("findvendor",arg)
	repeat
		vendorid=""
		vendorfound=false
		vendorids=ScanItems(true,{Type=vendortype},{ID=UO.CharID})
		for vendornum=1,#vendorids do
			vendorid=vendorids[vendornum].ID
			vendorname,vendorinfo=UO.Property(vendorid)
			vendorname2=string.lower(vendorname)
			if vendorids[vendornum].Dist<8 and vendorids[vendornum].Z<UO.CharPosZ+30 and vendorids[vendornum].Z>UO.CharPosZ-30 then
				for qw=#arg,1,-1 do
					argv=string.lower(arg[qw])
					if argv==string.match(vendorname2,argv) then
						vendorid=vendorids[vendornum].ID
						verbose2("findvendor",vendorid)
						return true,vendorid
					end
				end
			end
		end
	until vendorid~="" 
end
-------------------------------------------------------------------------------
function fish(fishkind) -- 						fish("fish") fish("net")
	verbose2("fish",fishkind)
	if fishkind=="net" then
		items=ScanItems(true,{Type=nettype})
		if #items > 0 then
			useobject(items[1].ID)
			targ(true,4000)
		end
		items=ScanItems(true,{Type=nettype})
		if #items > 0 then
			useobject(items[1].ID)
			targ(true,4000)
		end
	end
	if fishkind=="fish" then
		items=ScanItems(true,{Type=fishpoletype,ContID=backpack})
		if #items > 0 then
			useobject(items[1].ID)
			targ(true,4000)
		end
		items=ScanItems(true,{Type=fishpoletype,ContID=UO.CharID})
		if #items > 0 then
			useobject(items[1].ID)
			targ(true,4000)
		end
	end
	if UO.TargCurs==true then
		UO.LTargetX=UO.CharPosX + 3
		UO.LTargetY=UO.CharPosY - 3
		UO.LTargetZ=UO.CharPosZ
		UO.LTargetKind=2
		Journal.Mark()
		UO.Macro(22,0)
		targ(false,4000)
	end
end
-------------------------------------------------------------------------------
function follow(followid) --					follow(followid)
	verbose2("follow ",followid)
	followinfo=ScanItems(true,{ID=followid})
	if #followinfo>0 then
		if followinfo[1].Dist > 2 then
			UO.Move(followinfo[1].X,followinfo[1].Y)
			return
		end
	end
end
-------------------------------------------------------------------------------
function getbodammounts(currentbodid) --		currentbodneeded,currentbodcreated,currentbodleft=getbodammounts(bodid)
	verbose2("getbodammounts",currentbodid)
	getbodammountsname,getbodammountsinfo=UO.Property(currentbodid)
	getbodammountstemp=split(getbodammountsinfo,"\n")
	createdline=#getbodammountstemp
	neededline=createdline-1
	neededa=split(getbodammountstemp[neededline], " ")
	createda=split(getbodammountstemp[createdline], " ")
	currentbodneeded=neededa[#neededa]
	currentbodcreated=createda[#createda]
	currentbodleft=currentbodneeded-currentbodcreated
	if verbose then print(tonumber(currentbodneeded) .." " ..tonumber(currentbodcreated) .." " ..tonumber(currentbodleft)) end
	return tonumber(currentbodneeded),tonumber(currentbodcreated),tonumber(currentbodleft)
end
-------------------------------------------------------------------------------
function getcount(getcountbool) --				currcount,initcount,totcount=getcount(bShowtitle) --counts ingpots and gems and bool(shows in title or not)
	verbose2("Getingotcount",getcountbool)
	minetypes=ScanItems(true,{Type=jewelingtype})
	if #minetypes>0 then
		for mt=1,#minetypes do
			if minetypes[mt].Col==ircolor then
				if initingcount==true then 
					initcount["iron"]=initcount["iron"]+minetypes[mt].Stack
				end
				currcount["iron"]=currcount["iron"]+minetypes[mt].Stack
			end
			if minetypes[mt].Col==dccolor then
				if initingcount==true then 
					initcount["dull"]=initcount["dull"]+minetypes[mt].Stack
				end
				currcount["dull"]=currcount["dull"]+minetypes[mt].Stack
			end
			if minetypes[mt].Col==shcolor then
				if initingcount==true then 
					initcount["shad"]=initcount["shad"]+minetypes[mt].Stack
				end
				currcount["shad"]=currcount["shad"]+minetypes[mt].Stack
			end
			if minetypes[mt].Col==cocolor then
				if initingcount==true then 
					initcount["copp"]=initcount["copp"]+minetypes[mt].Stack
				end
				currcount["copp"]=currcount["copp"]+minetypes[mt].Stack
			end
			if minetypes[mt].Col==brcolor then
				if initingcount==true then 
					initcount["bron"]=initcount["bron"]+minetypes[mt].Stack
				end
				currcount["bron"]=currcount["bron"]+minetypes[mt].Stack
			end
			if minetypes[mt].Col==gocolor then
				if initingcount==true then 
					initcount["gold"]=initcount["gold"]+minetypes[mt].Stack
				end
				currcount["gold"]=currcount["gold"]+minetypes[mt].Stack
			end
			if minetypes[mt].Col==agcolor then
				if initingcount==true then 
					initcount["agap"]=initcount["agap"]+minetypes[mt].Stack
				end
				currcount["agap"]=currcount["agap"]+minetypes[mt].Stack
			end
			if minetypes[mt].Col==vecolor then
				if initingcount==true then 
					initcount["veri"]=initcount["veri"]+minetypes[mt].Stack
				end
				currcount["veri"]=currcount["veri"]+minetypes[mt].Stack
			end
			if minetypes[mt].Col==vacolor then
				if initingcount==true then 
					initcount["valo"]=initcount["valo"]+minetypes[mt].Stack
				end
				currcount["valo"]=currcount["valo"]+minetypes[mt].Stack
			end
			if minetypes[mt].Type==petype then
				if initingcount==true then
					initcount["pe"]=initcount["pe"]+minetypes[mt].Stack
				end
				currcount["pe"]=currcount["pe"]+minetypes[mt].Stack
			end
			if minetypes[mt].Type==tutype then
				if initingcount==true then
					initcount["tu"]=initcount["tu"]+minetypes[mt].Stack
				end
				currcount["tu"]=currcount["tu"]+minetypes[mt].Stack
			end
			if minetypes[mt].Type==bdtype then
				if initingcount==true then
					initcount["bd"]=initcount["bd"]+minetypes[mt].Stack
				end
				currcount["bd"]=currcount["bd"]+minetypes[mt].Stack
			end
			if minetypes[mt].Type==frtype then
				if initingcount==true then
					initcount["fr"]=initcount["fr"]+minetypes[mt].Stack
				end
				currcount["fr"]=currcount["fr"]+minetypes[mt].Stack
			end
			if minetypes[mt].Type==batype then
				if initingcount==true then
					initcount["ba"]=initcount["ba"]+minetypes[mt].Stack
				end
				currcount["ba"]=currcount["ba"]+minetypes[mt].Stack
			end
			if minetypes[mt].Type==ectype then
				if initingcount==true then
					initcount["ec"]=initcount["ec"]+minetypes[mt].Stack
				end
				currcount["ec"]=currcount["ec"]+minetypes[mt].Stack
			end
			if minetypes[mt].Type==dstype then
				if initingcount==true then
					initcount["ds"]=initcount["ds"]+minetypes[mt].Stack
				end
				currcount["ds"]=currcount["ds"]+minetypes[mt].Stack
			end
		end
	end
	minetypes=ScanItems(true,{Type=comdeed})
	if #minetypes>0 then
		for mt=1,#minetypes do
			lines=split(minetypes[mt].Details," ")
			if #lines>0 then
				if "Filled"==string.match(lines[3],"Filled") then
					lines=split(minetypes[mt].Name," ")
					if #lines>0 then
						linefour=tonumber(lines[4])
						if linefour>0 then
							linefive=string.lower(lines[5])
							if initingcount==true then
								initcount[linefive]=initcount[linefive]+linefour
							end
							currcount[linefive]=currcount[linefive]+linefour
						end
					end
				end
			end
		end
	end

	totcount["iron"]=currcount["iron"]-initcount["iron"]
	totcount["dull"]=currcount["dull"]-initcount["dull"]
	totcount["shad"]=currcount["shad"]-initcount["shad"]
	totcount["copp"]=currcount["copp"]-initcount["copp"]
	totcount["bron"]=currcount["bron"]-initcount["bron"]
	totcount["gold"]=currcount["gold"]-initcount["gold"]
	totcount["agap"]=currcount["agap"]-initcount["agap"]
	totcount["veri"]=currcount["veri"]-initcount["veri"]
	totcount["valo"]=currcount["valo"]-initcount["valo"]
	totcount["pe"]=currcount["pe"]-initcount["pe"]
	totcount["tu"]=currcount["tu"]-initcount["tu"]
	totcount["bd"]=currcount["bd"]-initcount["bd"]
	totcount["fr"]=currcount["fr"]-initcount["fr"]
	totcount["ba"]=currcount["ba"]-initcount["ba"]
	totcount["ec"]=currcount["ec"]-initcount["ec"]
	totcount["ds"]=currcount["ds"]-initcount["ds"]

	totals="iron " .. totcount["iron"] .. " dull " .. totcount["dull"] .. " shad " .. totcount["shad"] .. " copp " .. totcount["copp"] .. " bron " .. totcount["bron"] .. " gold " .. totcount["gold"] .. " agap " .. totcount["agap"] .. " veri " .. totcount["veri"] .. " valo " .. totcount["valo"] .. " pe " .. totcount["pe"] .. " tu " .. totcount["tu"] .. " bd " .. totcount["bd"] .. " fr " .. totcount["fr"] .. " ba " .. totcount["ba"] .. " ec " .. totcount["ec"] .. " ds " .. totcount["ds"]

	if getcountbool==true then
		newtitle=UO.CharName .. totals
		UO.CliTitle=newtitle
	end
	return currcount,initcount,totcount
end
-------------------------------------------------------------------------------
function getingots(material,ingstoget) --		getingots(material,ingstoget)
	verbose2("checkingots",material,ingstoget)
	colo=material
	materialsplit=split(material," ")
	material=string.lower(materialsplit[1])
	if material=="iron" then colo=0 end
	if material=="dull" then colo=2419 end
	if material=="shadow" then colo=2406 end 
	if material=="copper" then colo=2413 end
	if material=="bronze" then colo=2418 end
	if material=="gold" then colo=2213 end
	if material=="agapite" then colo=2425 end
	if material=="verite" then colo=2207 end
	if material=="valorite" then colo=2219 end 
	ingsinbackpack=ScanItems(true,{Type=ingottype,ContID=backpack,Col=colo})
	if #ingsinbackpack>0 then ingstograb=ingstoget-ingsinbackpack[1].Stack else ingstograb=ingstoget end
	print(ingstograb)
	if ingstograb>0 then
		repeat
			getingotstemp=ScanItems(true,{Type=ingottype,Col=colo},{ContID=backpack})
			if #getingotstemp>0 then UO.Drag(getingotstemp[1].ID,ingstograb) wait(halfsecond) UO.DropC(backpack) wait(onesecond) end
			ingsinbackpack=ScanItems(true,{Type=ingottype,ContID=backpack,Col=colo})
			if #ingsinbackpack>0 then ingstograb=ingstoget-ingsinbackpack[1].Stack else ingstograb=ingstoget end
		until ingstograb<1
	end
end
-------------------------------------------------------------------------------
function itemcheck() --							availablestorage=itemcheck()
	verbose2("Item check")
	local bagname,baginfo=UO.Property(backpack)
	local baginfosplita=split(baginfo," ")
	local baginfosplitb=split(baginfosplita[4],"/")
	local maxitems=baginfosplitb[2]
	local availablestorage=baginfosplitb[2] - baginfosplitb[1]
	if verbose then print("Item check Available item storage\\: " ..availablestorage) end
	return availablestorage
end
-------------------------------------------------------------------------------
function login(accountname,accountpassword,characternumber,loginid) --login(accountname,accountpassword,characternumber,loginid)
	verbose2("login",accountname,accountpassword,characternumber,loginid)
	repeat
		if UO.ContName=="MainMenu gump" then
			print("MainMenu")
			wait(onesecond)
			timex=getticks() + 6000
			repeat
				UO.Click(475,359,true,true,true,false) wait(tenthsecond)
				for i=1,30 do
					UO.Key("back",false,false,false) wait(5)
				end
				wait(tenthsecond)
				UO.Msg(accountname) wait(onesecond)
				UO.Click(475,399,true,true,true,false) wait(tenthsecond)
				for i=1,30 do
					UO.Key("back",false,false,false) wait(5)
				end
				wait(tenthsecond)
				UO.Msg(accountpassword) wait(tenthsecond)
				UO.Click(617,444,true,true,true,false) wait(onesecond)
			until UO.ContName~="MainMenu gump" or timex<getticks()
			wait(halfsecond)
		end
		if UO.ContName=="normal gump" then
			print("Shard")
			wait(onesecond)
			timex=getticks() + 6000
			repeat wait(tick)
				UO.Msg(string.char(13)) wait(onesecond)
				if timex<getticks() then
					UO.Click(318,349,true,true,true,false) wait(onesecond)
				end
			until UO.ContName~="normal gump" and UO.ContName~="MainMenu gump" or timex<getticks()
			wait(halfsecond)
		end
		
		if UO.ContName=="Login gump" then
			print("Login")
			wait(onesecond)
			timex=getticks() + 6000
			repeat wait(tick)
				clicy=characternumber*40+101
				UO.Click(360,clicy,true,true,true,false) wait(tick)
				UO.Click(360,clicy,true,true,true,false) wait(onesecond)
				UO.Click(617,444,true,true,true,false) wait(onesecond)
			until UO.ContName~="Login gump"
			timex=getticks() + 6000
			repeat wait(tick) until loginid==UO.CharID or timex<getticks()
			wait(halfsecond)
		end
		if UO.ContName=="waiting gump" then
			print("waiting")
			timex=getticks() + 9000
			repeat wait(tick) until UO.ContName~="waiting gump" or timex<getticks()
			if timex<getticks() then UO.Click(319,352,true,true,true,false) UO.Click(319,352,true,true,true,false) end
			wait(halfsecond)
		end
		UO.Macro(8,2) wait(onesecond)
		if UO.Str~=0 and loginid~=UO.CharID then logout() end
	until loginid==UO.CharID and UO.Str~=0
	wait(fivesecond)
	--clientsetup()
end
-------------------------------------------------------------------------------
function logout() --							logout()
	verbose2("logout")
	repeat
		if UO.ContName~="MainMenu gump" then
			repeat              
				UO.Macro(8,1) wait(onesecond)
				UO.ContPosX=540 UO.ContPosY=0 wait(tenthsecond) 
			until UO.ContName=="paperdoll gump"
		end
		if UO.ContName=="paperdoll gump" then
			timex=getticks() + 3000
			repeat
				clickxxyy(214,108) wait(tenthsecond)
			until UO.ContName=="YesNo gump" or timex < getticks()
		end
		if UO.ContName=="YesNo gump" then
			timex=getticks() + 3000
			repeat
				clickxxyy(122,86) wait(tenthsecond)
				wait(onesecond)
			until UO.ContName=="MainMenu gump" or timex < getticks()
		end
	until UO.ContName=="MainMenu gump"
	wait(tenthsecond)
end
-------------------------------------------------------------------------------
function magespell(spellname, ... ) --			magespell(spell)  magespell(spell,targetid)
	verbose2("magespell",spellname)
	string.lower(spellname)
	if spellname=="clumsy" then UO.Macro(15,0) targ(true,foursecond) end
	if spellname=="create food" then UO.Macro(15,1) end
	if spellname=="feeblemind" then UO.Macro(15,2) targ(true,foursecond) end
	if spellname=="heal" then UO.Macro(15,3) targ(true,foursecond) end
	if spellname=="magic arrow" then UO.Macro(15,4) targ(true,foursecond) end
	if spellname=="night sight" then UO.Macro(15,5) return end
	if spellname=="reactive armor" then UO.Macro(15,6) return end
	if spellname=="weaken" then UO.Macro(15,7) targ(true,foursecond) end
	if spellname=="agility" then UO.Macro(15,8) targ(true,foursecond) end
	if spellname=="cunning" then UO.Macro(15,9) targ(true,foursecond) end
	if spellname=="cure" then UO.Macro(15,10) targ(true,foursecond) end
	if spellname=="harm" then UO.Macro(15,11) targ(true,foursecond) end
	if spellname=="magic trap" then UO.Macro(15,12) targ(true,foursecond) end
	if spellname=="magic untrap" then UO.Macro(15,13) targ(true,foursecond) end
	if spellname=="protection" then UO.Macro(15,14) at=false repeat at=checkstringfor(UO.CharStatus, "A") until at==true return end
	if spellname=="strength" then UO.Macro(15,15) targ(true,foursecond) end
	if spellname=="bless" then UO.Macro(15,16) targ(true,foursecond) end
	if spellname=="fireball" then UO.Macro(15,17) targ(true,foursecond) end
	if spellname=="magic lock" then UO.Macro(15,18) targ(true,foursecond) end
	if spellname=="poison" then UO.Macro(15,19) targ(true,foursecond) end
	if spellname=="telekinesis" then UO.Macro(15,20) targ(true,foursecond) end
	if spellname=="teleport" then UO.Macro(15,21) targ(true,foursecond) end
	if spellname=="unlock" then UO.Macro(15,22) targ(true,foursecond) end
	if spellname=="wall of stone" then UO.Macro(15,23) targ(true,foursecond) end
	if spellname=="arch cure" then UO.Macro(15,24) targ(true,foursecond) end
	if spellname=="arch protection" then UO.Macro(15,25) targ(true,foursecond) end
	if spellname=="curse" then UO.Macro(15,26) targ(true,foursecond) end
	if spellname=="fire field" then UO.Macro(15,27) targ(true,foursecond) end
	if spellname=="greater heal" then UO.Macro(15,28) targ(true,foursecond) end
	if spellname=="lightning" then UO.Macro(15,29) targ(true,foursecond) end
	if spellname=="mana drain" then UO.Macro(15,30) targ(true,foursecond) end
	if spellname=="recall" then UO.Macro(15,31) targ(true,foursecond) end
	if spellname=="blade spirits" then UO.Macro(15,32) targ(true,eightsecond) end
	if spellname=="dispel field" then UO.Macro(15,33) targ(true,foursecond) end
	if spellname=="incognito" then UO.Macro(15,34) return end
	if spellname=="magic reflection" then UO.Macro(15,35) return end
	if spellname=="mind blast" then UO.Macro(15,36) targ(true,foursecond) end
	if spellname=="paralyze" then UO.Macro(15,37) targ(true,foursecond) end
	if spellname=="poison field" then UO.Macro(15,38) targ(true,foursecond) end
	if spellname=="summon creature" then UO.Macro(15,39) return end
	if spellname=="dispel" then UO.Macro(15,40) targ(true,foursecond) end
	if spellname=="energy bolt" then UO.Macro(15,41) targ(true,foursecond) end
	if spellname=="explosion" then UO.Macro(15,42) targ(true,foursecond) end
	if spellname=="invisibility" then UO.Macro(15,43) targ(true,foursecond) end
	if spellname=="mark" then UO.Macro(15,44) targ(true,foursecond) end
	if spellname=="mass curse" then UO.Macro(15,45) targ(true,foursecond) end
	if spellname=="paralyze field" then UO.Macro(15,46) targ(true,foursecond) end
	if spellname=="reveal" then UO.Macro(15,47) targ(true,foursecond) end
	if spellname=="chain lightning" then UO.Macro(15,48) targ(true,foursecond) end
	if spellname=="energy field" then UO.Macro(15,49) targ(true,foursecond) end
	if spellname=="flame strike" then UO.Macro(15,50) targ(true,foursecond) end
	if spellname=="gate travel" then UO.Macro(15,51) targ(true,foursecond) end
	if spellname=="mana vampire" then UO.Macro(15,52) targ(true,foursecond) end
	if spellname=="mass dispel" then UO.Macro(15,53) targ(true,foursecond) end
	if spellname=="meteor swarm" then UO.Macro(15,54) targ(true,foursecond) end
	if spellname=="polymorph" then UO.Macro(15,55) return end
	if spellname=="earthquake" then UO.Macro(15,56) return end
	if spellname=="energy vortex" then UO.Macro(15,57) targ(true,foursecond) end
	if spellname=="resurrection" then UO.Macro(15,58) targ(true,foursecond) end
	if spellname=="air elemental" then UO.Macro(15,59) return end
	if spellname=="summon daemon" then UO.Macro(15,60) return end
	if spellname=="earth elemental" then UO.Macro(15,61) return end
	if spellname=="fire elemental" then UO.Macro(15,62) return end
	if spellname=="water elemental" then UO.Macro(15,63) return end
	
	if #arg>0 then
		if arg[1]=="self" then
			targetitem("self")
		else
			targetitem(arg[1])
		end
	end
--[[ lvl 1 mage
15  0    Clumsy  
15  1    create food  
15  2    feeblemind  
15  3    heal  
15  4    magic arrow  
15  5    night sight  
15  6    reactive armor  
15  7    weaken  
]]
--[[ lvl 2 mage  
15  8    agility 
15  9    cunning  
15  10    cure  
15  11    harm  
15  12    magic trap  
15  13    magic untrap  
15  14    protection  
15  15    strength  
]]
--[[ lvl 3 mage
15  16    bless  
15  17    fireball  
15  18    magic lock  
15  19    poison  
15  20    telekinesis  
15  21    teleport  
15  22    unlock  
15  23    wall of stone  
]]
--[[ lvl 4 mage 
15  24    arch cure 
15  25    arch protection  
15  26    curse  
15  27    fire field  
15  28    greater heal  
15  29    lightning  
15  30    mana drain  
15  31    recall  
]]
--[[ lvl 5 mage
15  32    blade spirits  
15  33    dispel field  
15  34    incognito  
15  35    magic reflection  
15  36    mind blast  
15  37    paralyze  
15  38    poison field  
15  39    summon creature  
]]
--[[ lvl 6 mage 
15  40    dispel 
15  41    energy bolt  
15  42    explosion  
15  43    invisibility  
15  44    mark  
15  45    mass curse  
15  46    paralyze field  
15  47    reveal  
]]
--[[ lvl 7 mage 
15  48    chain lightning 
15  49    energy field  
15  50    flame strike  
15  51    gate travel  
15  52    mana vampire  
15  53    mass dispel  
15  54    meteor swarm  
15  55    polymorph  
]]
--[[ lvl 8 mage 
15  56    earthquake  
15  57    energy vortex  
15  58    resurrection  
15  59    air elemental  
15  60    summon daemon  
15  61    earth elemental  
15  62    fire elemental  
15  63    water elemental  
]]
end
-------------------------------------------------------------------------------
function makeitem(currentbodid,itype,quality,menu,currentbodleft,itemcaraftinfo)
	if verbose then print("makeitem " ..currentbodid .." " ..itype .." " ..quality .." " ..menu .." " ..currentbodleft .." " ..itemcaraftinfo) end
	needash(false)
	if quality=="Exceptional" and material~="Iron Ingots" then
		if itype==5136 or itype==5137 or itype==5141 or itype==5138 then
			needash(true)
		end --platemail arms=5136	platemail legs=5137 platemail (tunic)=5141 plate helm=5138
	end
	repeat
	usetool("tong")
	--checkingots(material,ingotsneeded,currentbodleft)
	makeitemtemp=split(menu,"_")
	makeitemtempyy=makeitemtemp[1] * 20 + 70
	clickxxyy(30,makeitemtempyy) repeat wait(tick) until UO.ContName=="generic gump" and UO.ContSizeX==530 and UO.ContSizeY==497
	wait(halfsecond)
	if tonumber(makeitemtemp[2])>9 then
		clickxxyy(385,270) repeat wait(tick) until UO.ContName=="generic gump" and UO.ContSizeX==530 and UO.ContSizeY==497
		wait(halfsecond)
		makeitemtemp[2]=tonumber(makeitemtemp[2])-10
	end
	if tonumber(makeitemtemp[2])>19 then
		clickxxyy(385,270) repeat wait(tick) until UO.ContName=="generic gump" and UO.ContSizeX==530 and UO.ContSizeY==497
		wait(halfsecond)
		makeitemtemp[2]=tonumber(makeitemtemp[2])-10
	end
	makeitemtempyy=makeitemtemp[2] * 20 + 70
	tempkalx=UO.ContPosX+255 tempkaly=makeitemtemp[2] * 20 + UO.ContPosY + 63
	tempkal=KAL.TextScan(tempkalx, tempkaly, "in", 16777215 , "text","       ")
	until tempkal==itemcaraftinfo
	timex=getticks() + 2000
	clickxxyy(235,makeitemtempyy) 
	repeat wait(tick) 
		if timex < getticks() then usetool("tong") end
	until UO.ContName=="generic gump" and UO.ContSizeX==530 and UO.ContSizeY==497
	repeat
		if currentbodleft>0 then
			ingstoget=ingotsneeded*currentbodleft
			getingots(material,ingstoget)
			getbodammounts(currentbodid) --currentbodneeded,currentbodcreated,currentbodleft
			countpieces(itype,"normal") --countpiecestot
			currentbodleft=currentbodneeded-currentbodcreated-countpiecestot
			for makeitemtempb=1,currentbodleft do
				if verbose then print(currentbodid .." " ..itype .." " ..menu .." " ..makeitemtempb .." of " ..currentbodleft) end
				clickxxyy(287,452)
				timex=getticks() + 2000
				repeat wait(tick) if timex < getticks() then usetool("tong") end
				until UO.ContName=="generic gump" and UO.ContSizeX==530 and UO.ContSizeY==497
			end
		end
		getbodammounts(currentbodid) --currentbodneeded,currentbodcreated,currentbodleft
		countpieces(itype,quality) --countpiecestot
		currentbodleft=currentbodneeded-currentbodcreated-countpiecestot
	until currentbodleft<1
	repeat
		getbodammounts(currentbodid) --currentbodneeded,currentbodcreated,currentbodleft
		countpieces(itype,quality) --countpiecestot
		currentbodleft=currentbodneeded-currentbodcreated-countpiecestot
		if currentbodleft<0 then
			smeltitem(currentcountpiecesid)
		end
	until currentbodleft==0 
	clickxxyy(30,453)
	repeat wait(tick) 
	until UO.ContSizeX~=530 and UO.ContSizeY~=497
end
-------------------------------------------------------------------------------
function maketool(tool) --						maketool("shovel")  ,  maketool("tink")  , maketool("tong")
	verbose2("maketool",tool)
	getingots("iron",30)
	repeat
		tinks=ScanItems(true,{Type=tinkertooltype,ContID=backpack})
		if #tinks<2 then 
			useobject(tinks[#tinks].ID)
			waitforgump("tinksz",true)
			try=Craft_ItemName("tinkering","tinker's tools")
			clickmakelast()	
			clickmakelast()
			clickmakeexit()
		end
		tinks=ScanItems(true,{Type=tinkertooltype,ContID=backpack})
	until #tinks>1
	if tool=="shovel" then
		tinks=ScanItems(true,{Type=tinkertooltype,ContID=backpack})
		useobject(tinks[#tinks].ID)
		waitforgump("tinksz",true)
		try=Craft_ItemName("tinkering","shovel")
		clickmakelast()	
		clickmakelast()
		clickmakeexit()
	end
	if tool=="tong" then
		tinks=ScanItems(true,{Type=tinkertooltype,ContID=backpack})
		useobject(tinks[#tinks].ID)
		waitforgump("tinksz",true)
		try=Craft_ItemName("tinkering","tongs")
		clickmakelast()	
		clickmakelast()
		clickmakeexit()
	end
end
-------------------------------------------------------------------------------
function matchbods() --							items,pulltable=matchbods()
	verbose2("matchbods")
	--recallto("house")
	opencontainers(sortchests)
	local index = 0
	local items = {}
	pullers=""
	filterscleared=false
	books=ScanItems(true,{Type=bodbooktype})
	if #books>0 then
		for booknum = 1,#books do
			if verbose==true then print(booknum .. " of " .. #books) end
			book={}
			curbookid=books[booknum].ID
			curbookchestid=books[booknum].ContID
			count,name,info=pollbodbook(curbookid)
			useobject(curbookid)
			wait(onesecond) 
			if filterscleared==false then
				clickxxyy(49,42)
				wait(onesecond) 
				clickxxyy(216,425)
				wait(onesecond) 
				clickxxyy(386,425)
				wait(onesecond) 
				clickxxyy(520,425)
				wait(onesecond) 
				filterscleared=true
			end
			page=1 
			booktot=0                                                                                                                                                       
			repeat
				XPos=UO.ContPosX
				YPos=UO.ContPosY
				GumpSize=UO.ContSizeX      
				a=KAL.GetBodInfo(XPos,YPos,GumpSize)
				for f=1,#a do
					a[f]["Book"]=curbookid
				    table.insert(items,a[f])
				end
				page=page+1
				clickxxyy(242,425)
				waitforgump("bodbooksz",true)
				wait(thirdsecond)
				booktot=booktot+#a
			until booktot==count
			clickxxyy(390,425)
			waitforgump("bodbooksz",false)
			wait(thirdsecond)
		end
	end
	writef(getinstalldir().."scripts\\" .. bodstxt,"return { \n" .. TableToString(items) .. "\n }",false)
	largetable={}
	smalltable={}
	pulltable={}
	largecount=0
	smallcount=0
	for index=1,#items do
		if items[index][1]["Type"]=="Large" then
			largecount=largecount+1
			largetable[largecount]=items[index]
			largetable[largecount]["Index"]=index
			largetable[largecount]["Pull"]=false
			for P = 1,#largetable[largecount] do
			    largetable[largecount][P]["Pair"]={}
			    largetable[largecount][P]["Pair"]=0
				lamtemp2=largetable[largecount][P]["Amount"]
				lamtemp1=split(lamtemp2," / ")
				largetable[largecount][P]["Amount"]=lamtemp1[2]
            end
		end
		if items[index][1]["Type"]=="Small" then
			smallcount=smallcount+1
			smalltable[smallcount]=items[index]
			smalltable[smallcount][1]["Index"]=index
			smalltable[smallcount][1]["Pair"]={}
			smalltable[smallcount][1]["Pair"]=0
			smalltable[smallcount][1]["Pull"]=false
			samtemp2=smalltable[smallcount][1]["Amount"]
			samtemp1=split(samtemp2," / ")
			smalltable[smallcount][1]["Amount"]=samtemp1[2]
		end
	end
	for L=1,largecount do
		for P = 1,#largetable[L] do
			lit=largetable[L][P]["Item"]
			lam=largetable[L][P]["Amount"]
			lma=largetable[L][P]["Material"]
			lqu=largetable[L][P]["Quality"]
			lpa=largetable[L][P]["Pair"]
			for S=1,smallcount do
				sit=smalltable[S][1]["Item"]
				sam=smalltable[S][1]["Amount"]
				sma=smalltable[S][1]["Material"]
				squ=smalltable[S][1]["Quality"]
				spu=smalltable[S][1]["Pull"]
				spa=smalltable[S][1]["Pair"]
				if sit==lit and sam==lam and lma==sma and lqu==squ and lpa==0 and spa==0 then 
					smalltable[S][1]["Pair"]=largetable[L]["Index"]
					largetable[L][P]["Pair"]=smalltable[S][1]["Index"]
					break
				end
			end
		end
	end
	for L=1,largecount do
		test=0 
		largetable[L]["Pairs"]="__" .. largetable[L]["Index"] .. "_" 
		for P = 1,#largetable[L] do
			lpa="_" .. largetable[L][P]["Pair"] .. "_"
			if lpa=="_0_" then
				break
			else
				test=test+1
				largetable[L]["Pairs"]=(largetable[L]["Pairs"] .. lpa)
				if test==#largetable[L] then 
					largetable[L]["Pull"]=true
					table.insert(pulltable,largetable[L])
					if tostring(largetable[L]["Book"]) ~=string.match(tostring(pulltable["bookstopullfrom"]),tostring(largetable[L]["Book"])) then
						pulltable["bookstopullfrom"]=largetable[L]["Book"]
					end
					for S=1,smallcount do
						if "_" .. tostring(smalltable[S][1]["Index"]) .. "_" ==string.match(largetable[L]["Pairs"],"_" .. tostring(smalltable[S][1]["Index"]) .. "_") then
							smalltable[S][1]["Pull"]=true
							table.insert(pulltable,smalltable[S])
							if tostring(smalltable[S]["Book"]) ~=string.match(tostring(pulltable["bookstopullfrom"]),tostring(smalltable[S]["Book"])) then
								pulltable["bookstopullfrom"]=smalltable[S]["Book"]
							end
						end
					end
				end
			end
		end
		largetable[L]["Pairs"]=(largetable[L]["Pairs"] .. "_")
	end
	writef(getinstalldir().."scripts\\bodspull.txt","return { \n" .. TableToString(pulltable) .. "\n }",false)
	return items,pulltable
end
-------------------------------------------------------------------------------
function matchbodspull(booktoplacebods, ... ) --matchbodspull()
	verbose2("matchbodspull",booktoplacebods)
	if #arg==1 then bodspulltxt=arg[1] else bodspulltxt=dofile(getinstalldir().."scripts\\bodspull.txt") end
	local items = {}
	books=ScanItems(true,{Type=bodbooktype})
	if #books>0 then
		for booknum = 1,#books do
		qws=bodspulltxt[1]["bookstopullfrom"]
		if tostring(books[booknum].ID) ==string.match(tostring(qws),tostring(books[booknum].ID)) then
			if verbose==true then print(booknum .. " of " .. #books) end
			curbookid=books[booknum].ID
			curbookchestid=books[booknum].ContID
			Drag(curbookid,curbookchestid,backpack)
			useobject(curbookid)
			count,name,info=pollbodbook(curbookid)
			booktot=0
			repeat
				repeat
					book={}
					wait(onesecond) 
					page=1 
					doover=false
					XPos=UO.ContPosX
					YPos=UO.ContPosY
					GumpSize=UO.ContSizeX      
					a=KAL.GetBodInfo(XPos,YPos,GumpSize)
					posy=1
					for f=1,#a do
						booktot=booktot+1
						if a[f][1]["Type"]=="Large" then
							for pulltxt=1,#bodspulltxt[1] do
								print("")
								print(a[f][1]["Type"] .. " " .. bodspulltxt[1][pulltxt][1]["Type"])
								print(a[f][1]["Item"] .. " " .. bodspulltxt[1][pulltxt][1]["Item"])
								atemp=a[f][1]["Amount"]
								atem2=split(atemp," / ")
								print(atem2[2] .. " " .. bodspulltxt[1][pulltxt][1]["Amount"])
								print(a[f][1]["Material"] .. " " .. bodspulltxt[1][pulltxt][1]["Material"])
								print(a[f][1]["Quality"] .. " " .. bodspulltxt[1][pulltxt][1]["Quality"])
								if bodspulltxt[1][pulltxt]["Pull"]==true and bodspulltxt[1][pulltxt][1]["Type"]=="Large" then
									if a[f][1]["Item"]==bodspulltxt[1][pulltxt][1]["Item"] and atem2[2]==bodspulltxt[1][pulltxt][1]["Amount"] and a[f][1]["Material"]==bodspulltxt[1][pulltxt][1]["Material"] and a[f][1]["Quality"]==bodspulltxt[1][pulltxt][1]["Quality"] then
										cx=42
										cy=posy*32+72
										clickxxyy(cx,cy)
										doover=true
										bodspulltxt[1][pulltxt][1]["Type"]="Pulled"
										useobject(curbookid)
										wait(onesecond)
										count,name,info=pollbodbook(curbookid)
										booktot=0
										break
									end 
								end
							end
						end
						if a[f][1]["Type"]=="Small" then
							for pulltxt=1,#bodspulltxt[1] do
								print("")
								print(a[f][1]["Type"] .. " " .. bodspulltxt[1][pulltxt][1]["Type"])
								print(a[f][1]["Item"] .. " " .. bodspulltxt[1][pulltxt][1]["Item"])
								atemp=a[f][1]["Amount"]
								atem2=split(atemp," / ")
								print(atem2[2] .. " " .. bodspulltxt[1][pulltxt][1]["Amount"])
								print(a[f][1]["Material"] .. " " .. bodspulltxt[1][pulltxt][1]["Material"])
								print(a[f][1]["Quality"] .. " " .. bodspulltxt[1][pulltxt][1]["Quality"])
								if bodspulltxt[1][pulltxt][1]["Pull"]==true and bodspulltxt[1][pulltxt][1]["Type"]=="Small" then
									atemp=a[f][1]["Amount"]
									atem2=split(atemp," / ")
									if a[f][1]["Item"]==bodspulltxt[1][pulltxt][1]["Item"] and atem2[2]==bodspulltxt[1][pulltxt][1]["Amount"] and a[f][1]["Material"]==bodspulltxt[1][pulltxt][1]["Material"] and a[f][1]["Quality"]==bodspulltxt[1][pulltxt][1]["Quality"] then
										cx=42
										cy=posy*32+72
										clickxxyy(cx,cy)
										doover=true
										bodspulltxt[1][pulltxt][1]["Type"]="Pulled"
										useobject(curbookid)
										wait(onesecond)
										count,name,info=pollbodbook(curbookid)
										booktot=0
										break
									end 
								end
							end
						end
						if doover==true then break end
						posy=posy+#a[f]
					end
					if doover==false then
						page=page+1
						clickxxyy(242,425)
						waitforgump("bodbooksz",true)
						wait(thirdsecond)
					end
				until doover==false
			until booktot==count
			clickxxyy(390,425)
			waitforgump("bodbooksz",false)
			wait(thirdsecond)

			Drag(curbookid,backpack,curbookchestid)
			newbod=ScanItems(true,{Type=bodtype,ContID=UO.BackpackID})
			if #newbod>0 then
				putbodinbook(booktoplacebods)
			end
		end
		end
	end
end
-------------------------------------------------------------------------------
function movebehindmast(tillerid) --			bSuccess=movebehindmast(tillerid)
	verbose2("movebehindmast",tillerid)
	UO.Macro(5,0) UO.Macro(5,0) 
	t=ScanItems(true,{ID=tillerid})
	if #t>0 then
		for q=1,#t do
			if t[q].ID==tillerid then
				if tillermanfacingnorth==t[q].Type then movex=t[q].X-1 movey=t[q].Y-3 end
				if tillermanfacingsouth==t[q].Type then movex=t[q].X movey=t[q].Y+3 end
				if tillermanfacingeast==t[q].Type then movex=t[q].X+3 movey=t[q].Y end
				if tillermanfacingwest==t[q].Type then movex=t[q].X-3 movey=t[q].Y end
				for m=1,3 do
					UO.Move(movex,movey)
				end
				wait(onesecond)
				if UO.CharPosX==movex and UO.CharPosY==movey then
					return true
				else
					return false
				end
			end
		end
	end
end
-------------------------------------------------------------------------------
function movenexttomast(tillerid) --			bSuccess=movebehindmast(tillerid)
	verbose2("movenexttomast",tillerid)
	UO.Macro(5,0) UO.Macro(5,0) 
	t=ScanItems(true,{ID=tillerid})
	if #t>0 then
		for q=1,#t do
			if t[q].ID==tillerid then
				if tillermanfacingnorth==t[q].Type then movex=t[q].X movey=t[q].Y-3 end
				if tillermanfacingsouth==t[q].Type then movex=t[q].X-1 movey=t[q].Y+3 end
				if tillermanfacingeast==t[q].Type then movex=t[q].X+3 movey=t[q].Y+1 end
				if tillermanfacingwest==t[q].Type then movex=t[q].X-3 movey=t[q].Y-1 end
				for m=1,3 do
					UO.Move(movex,movey)
				end
				wait(onesecond)
				if UO.CharPosX==movex and UO.CharPosY==movey then
					return true
				else
					return false
				end
			end
		end
	end
end
-------------------------------------------------------------------------------
function moveto(movetospot) --					bSuccess=moveto([1]="2604_152",[2]="2604_148")
	verbose2("moveto",movetospot)
	if #movetospot>0 then
		for spotxy=1,#movetospot do
			local tempspotxy=movetospot[spotxy]
			spotxxyy=split(tempspotxy,"_")
			spota=tonumber(spotxxyy[1])
			spotb=tonumber(spotxxyy[2])
			oldx=UO.CharPosX oldy=UO.CharPosY
			print("move" .. spota .. " " .. spotb)
			local bsuccess=UO.Move(spota,spotb)
			local bsuccess=UO.Move(spota,spotb)
			if UO.CharPosX .. "_" .. UO.CharPosY==movetospot[#movetospot] then return true end
			if UO.CharPosX~=spota or UO.CharPosY~=spotb then
				print("pathfind " .. spota .. " " .. spotb)
				local bsuccess=UO.Pathfind(spota,spotb)
				repeat if UO.CharPosX .. "_" .. UO.CharPosY==movetospot[#movetospot] then return true end until UO.CharPosX==spota and UO.CharPosY==spotb
			end
			--teleport tile
			print("teleport tile")
			local tile=ScanItems(true,{Type=teleporttiletype})
			if UO.CharPosX .. "_" .. UO.CharPosY==movetospot[#movetospot] then return true end
			if #tile>0 then
				for tilenum=1,#tile do
					if tile[tilenum].X==UO.CharPosX and tile[tilenum].Y==UO.CharPosY then
						timex=getticks() + 6000
						movetryx=UO.CharPosX movetryy=UO.CharPosY
						repeat wait(tick) until timex < getticks() or waitforgump("tofelsz",true) or movetryx~=UO.CharPosX or movetryy~=UO.CharPosY
					end
				end
			end
			--to fel
			print("to fel")
			if contsz(420,280,true) then
				timer = getticks() 
				clickxxyy(25,260)
				moved=waitformove(timer,ninesecond)
				wait(tenthsecond)
			end 
			--doors
			print("doors")
			local doors=ScanItems(true,{Type=doortype})
			if UO.CharPosX .. "_" .. UO.CharPosY==movetospot[#movetospot] then return true end
			if #doors>0 then
				for doornum=1,#doors do
					if doors[doornum].Y==UO.CharPosY-1 and doors[doornum].X==UO.CharPosX then 
						doorid=doors[doornum].ID
						doorx=doors[doornum].X doory=doors[doornum].Y
						tryx=UO.CharPosX tryy=UO.CharPosY
						repeat
						useobject(doorid) wait(thirdsecond)
						UO.Macro(5,1) UO.Macro(5,1)
						currdoor=ScanItems(true,{ID=doorid})
						until currdoor[1].X ~= doorx or currdoor[1].Y ~= doory and tryx~=UO.CharPosX or tryy~=UO.CharPosY
						break
					end
					if doors[doornum].Y==UO.CharPosY+1 and doors[doornum].X==UO.CharPosX then
						doorid=doors[doornum].ID
						doorx=doors[doornum].X doory=doors[doornum].Y
						tryx=UO.CharPosX tryy=UO.CharPosY
						repeat
						useobject(doorid) wait(thirdsecond)
						UO.Macro(5,1) UO.Macro(5,1)
						currdoor=ScanItems(true,{ID=doorid})
						until currdoor[1].X ~= doorx or currdoor[1].Y ~= doory and tryx~=UO.CharPosX or tryy~=UO.CharPosY
						break
					end
					if doors[doornum].Y==UO.CharPosY and doors[doornum].X==UO.CharPosX-1 then
						doorid=doors[doornum].ID
						doorx=doors[doornum].X doory=doors[doornum].Y
						tryx=UO.CharPosX tryy=UO.CharPosY
						repeat
						useobject(doorid) wait(thirdsecond)
						UO.Macro(5,1) UO.Macro(5,1)
						currdoor=ScanItems(true,{ID=doorid})
						until currdoor[1].X ~= doorx or currdoor[1].Y ~= doory and tryx~=UO.CharPosX or tryy~=UO.CharPosY
						break
					end
					if doors[doornum].Y==UO.CharPosY and doors[doornum].X==UO.CharPosX+1 then 
						doorid=doors[doornum].ID
						doorx=doors[doornum].X doory=doors[doornum].Y
						tryx=UO.CharPosX tryy=UO.CharPosY
						repeat
						useobject(doorid) wait(thirdsecond)
						UO.Macro(5,1) UO.Macro(5,1)
						currdoor=ScanItems(true,{ID=doorid})
						until currdoor[1].X ~= doorx or currdoor[1].Y ~= doory and tryx~=UO.CharPosX or tryy~=UO.CharPosY
						break
					end
				end
			end
		end
	end
	return true
end
-------------------------------------------------------------------------------
function navigateto(xcoord,ycoord,tillerid, ... ) --navigateto(2192,1005,tillerid,boolslow)
	verbose2("navigateto",xcoord,ycoord,tillerid)
	if arg[1]==true then slow=true else slow=false end
	if verbose then print("navigateto " .. xcoord .. " " .. ycoord .. " " .. tillerid) end
	local timex=getticks() + 6000
	repeat wait(tick)
		t=ScanItems(true,{ID=tillerid})
		if timex < getticks() then 
			return false 
		end 
	until #t>0
	wait(onesecond)
	sailtimer=getticks()
	stoppedy=UO.CharPosY
	stoppedx=UO.CharPosX
	repeat
		if xcoord < UO.CharPosX then xdist=UO.CharPosX - xcoord end
		if xcoord > UO.CharPosX then xdist=xcoord - UO.CharPosX end
		if xcoord == UO.CharPosX then xdist=0 end
		if UO.CharPosX - xcoord > 4000 then Say("stop") stop() end
		--checky:
		if ycoord < UO.CharPosY then ydist=UO.CharPosY - ycoord end
		if ycoord > UO.CharPosY then ydist=ycoord - UO.CharPosY end
		if ycoord == UO.CharPosY then ydist=0 end
		--setdirection:
		if xdist > ydist and xcoord > UO.CharPosX then navigatefaceboat("east",tillerid) facing="east" end
		if xdist > ydist and xcoord < UO.CharPosX then navigatefaceboat("west",tillerid) facing="west" end	
		if xdist < ydist and ycoord < UO.CharPosY then navigatefaceboat("north",tillerid) facing="north" end
		if xdist < ydist and ycoord > UO.CharPosY then navigatefaceboat("south",tillerid) facing="south" end
		--startmoving:
		if finddist(xcoord,ycoord)<3 then slow=true else slow=false end
		if UO.CharPosX < 25 then slow=true else slow=false end
		if facing == "north" then 
			if xcoord < UO.CharPosX - 3 and heading~=7 and slow==true then Say("slow forward left") wait(onesecond) heading=7 end
			if xcoord < UO.CharPosX - 3 and heading~=7 and slow~=true then Say("forward left") wait(onesecond) heading=7 end
			if xcoord > UO.CharPosX + 3 and heading ~=1 and slow==true then Say("slow forward right") wait(onesecond) heading=1 end
			if xcoord > UO.CharPosX + 3 and heading ~=1 and slow~=true then Say("forward right") wait(onesecond) heading=1 end
			if xcoord < UO.CharPosX + 3 and xcoord > UO.CharPosX - 3 and heading~=0 and slow==true then Say("slow forward") wait(onesecond) heading=0 end
			if xcoord < UO.CharPosX + 3 and xcoord > UO.CharPosX - 3 and heading~=0 and slow~=true then Say("forward") wait(onesecond) heading=0 end
		end
		if facing == "south" then
			if xcoord < UO.CharPosX - 3 and heading~=1 and slow==true then Say("slow forward right") wait(onesecond) heading=1 end
			if xcoord < UO.CharPosX - 3 and heading~=1 and slow~=true then Say("forward right") wait(onesecond) heading=1 end
			if xcoord > UO.CharPosX + 3 and heading ~=7 and slow==true then Say("slow forward left") wait(onesecond) heading=7 end
			if xcoord > UO.CharPosX + 3 and heading ~=7 and slow~=true then Say("forward left") wait(onesecond) heading=7 end
			if xcoord < UO.CharPosX + 3 and xcoord > UO.CharPosX - 3 and heading~=0 and slow==true then Say("slow forward") wait(onesecond) heading=0 end
			if xcoord < UO.CharPosX + 3 and xcoord > UO.CharPosX - 3 and heading~=0 and slow~=true then Say("forward") wait(onesecond) heading=0 end
		end
		if facing == "west" then
			if ycoord < UO.CharPosY - 3 and heading~=1 and slow==true then Say("slow forward right") wait(onesecond) heading=1 end
			if ycoord < UO.CharPosY - 3 and heading~=1 and slow~=true then Say("forward right") wait(onesecond) heading=1 end
			if ycoord > UO.CharPosY + 3 and heading ~=7 and slow==true then Say("slow forward left") wait(onesecond) heading=7 end
			if ycoord > UO.CharPosY + 3 and heading ~=7 and slow~=true then Say("forward left") wait(onesecond) heading=7 end
			if ycoord < UO.CharPosY + 3 and ycoord > UO.CharPosY - 3 and heading~=0 and slow==true then Say("slow forward") wait(onesecond) heading=0 end
			if ycoord < UO.CharPosY + 3 and ycoord > UO.CharPosY - 3 and heading~=0 and slow~=true then Say("forward") wait(onesecond) heading=0 end
		end
		if facing == "east" then
			if ycoord < UO.CharPosY - 3 and heading~=7 and slow==true then Say("slow forward left") wait(onesecond) heading=7 end
			if ycoord < UO.CharPosY - 3 and heading~=7 and slow~=true then Say("forward left") wait(onesecond) heading=7 end
			if ycoord > UO.CharPosY + 3 and heading ~=1 and slow==true then Say("slow forward right") wait(onesecond) heading=1 end
			if ycoord > UO.CharPosY + 3 and heading ~=1 and slow~=true then Say("forward right") wait(onesecond) heading=1 end
			if ycoord < UO.CharPosY + 3 and ycoord > UO.CharPosY - 3 and heading~=0 and slow==true then Say("slow forward") wait(onesecond) heading=0 end
			if ycoord < UO.CharPosY + 3 and ycoord > UO.CharPosY - 3 and heading~=0 and slow~=true then Say("forward") wait(onesecond) heading=0 end
		end
		if xcoord < UO.CharPosX + 3 and xcoord > UO.CharPosX - 3 then
			if ycoord < UO.CharPosY + 3 and ycoord > UO.CharPosY - 3 then
				Say("stop")
				return true
			end
		end
		if sailtimer < getticks() then 
			if stoppedx~=UO.CharPosX or stoppedy~=UO.CharPosY then
				stoppedy=UO.CharPosY
				stoppedx=UO.CharPosX
				sailtimer=getticks() + 4000 
			else
				navigateunblockboat()
			end
		end
		--[[
		findserptokill()
		checkhealth()
		checkweight()
		checkstopped()
		]]
	until "a"=="b"
end
-------------------------------------------------------------------------------
function navigateunblockboat() --				navigateunblockboat()
	Say(Back)
	timex = getticks() + fivesecond
	repeat
		findenemytokill()
	until timex < getticks()
	rand=math.random(1,2)
	if rand == 1 then
		rtlt="left"
	else
		rtlt="right"
	end
	Say(rtlt)
	timex = getticks() + elevensecond
	repeat
		findenemytokill()
	until timex < getticks()
	Say("forward")
	timex = getticks() + elevensecond
	repeat
		findenemytokill()
	until timex < getticks()

end
-------------------------------------------------------------------------------
			function navigateunblockboat2() --							Not working yet
	--CmpPix(XPos, YPos, PixOP, PixCmp) cmp=CmpPix(400, 400, "in", _12984_13256_) if cmp==true then...
	--local PixCol = UO.GetPix(XPos,YPos)
end
-------------------------------------------------------------------------------
function navigatefaceboat(direction,tillerid) --navigatefaceboat("north",tillerid)
	--verbose2("navigatefaceboat",direction,tillerid)
	if direction=="north" then 
		repeat --0
			t=ScanItems(true,{ID=tillerid})
			if #t>0 then
				for q=1,#t do
					if t[q].ID==tillerid then
						if tillermanfacingnorth==t[q].Type then return true end
						if tillermanfacingsouth==t[q].Type then Say("come about") end
						if tillermanfacingeast==t[q].Type then Say("turn left") end
						if tillermanfacingwest==t[q].Type then Say("turn right") end
						wait(onesecond)
					end
				end
			end
			t=ScanItems(true,{ID=tillerid,Type=tillermanfacingnorth})
		until #t>0
	end
	if direction=="south" then 
		repeat --0
			t=ScanItems(true,{ID=tillerid})
			if #t>0 then
				for q=1,#t do
					if t[q].ID==tillerid then
						if tillermanfacingsouth==t[q].Type then return true end
						if tillermanfacingnorth==t[q].Type then Say("come about") end
						if tillermanfacingwest==t[q].Type then Say("turn left") end
						if tillermanfacingeast==t[q].Type then Say("turn right") end
						wait(onesecond)
					end
				end
			end
			t=ScanItems(true,{ID=tillerid,Type=tillermanfacingsouth})
		until #t>0
	end
	if direction=="east" then 
		repeat --0
			t=ScanItems(true,{ID=tillerid})
			if #t>0 then
				for q=1,#t do
					if t[q].ID==tillerid then
						if tillermanfacingeast==t[q].Type then return true end
						if tillermanfacingwest==t[q].Type then Say("come about") end
						if tillermanfacingsouth==t[q].Type then Say("turn left") end
						if tillermanfacingnorth==t[q].Type then Say("turn right") end
						wait(onesecond)
					end
				end
			end
			tt=ScanItems(true,{ID=tillerid,Type=tillermanfacingeast})
		until #tt>0
	end
	if direction=="west" then 
		repeat --0
			t=ScanItems(true,{ID=tillerid})
			if #t>0 then
				for q=1,#t do
					if t[q].ID==tillerid then
						if tillermanfacingwest==t[q].Type then return true end
						if tillermanfacingeast==t[q].Type then Say("come about") end
						if tillermanfacingnorth==t[q].Type then Say("turn left") end
						if tillermanfacingeast==t[q].Type then Say("turn right") end
						wait(onesecond)
					end
				end
			end
			t=ScanItems(true,{ID=tillerid,Type=tillermanfacingwest})
		until #t>0
	end
end
-------------------------------------------------------------------------------
function necrospell(spellname,...) --			necrospell(spell)  necrospell(spell,targetid)
	verbose2("necrospell",spellname)
	string.lower(spellname)
	if spellname=="animate dead" then UO.Macro(15,101) targ(true,foursecond) end
	if spellname=="blood oath" then UO.Macro(15,102) targ(true,foursecond) end
	if spellname=="corpse skin" then UO.Macro(15,103) targ(true,foursecond) end
	if spellname=="curse weapon" then UO.Macro(15,104) return end
	if spellname=="evil omen" then UO.Macro(15,105) targ(true,foursecond) end
	if spellname=="horrific beast" then UO.Macro(15,106) return end
	if spellname=="lich form" then UO.Macro(15,107) return end
	if spellname=="mind rot" then UO.Macro(15,108) targ(true,foursecond) end
	if spellname=="pain spike" then UO.Macro(15,109) targ(true,foursecond) end
	if spellname=="poison strike" then UO.Macro(15,110) targ(true,foursecond) end
	if spellname=="strangle" then UO.Macro(15,111) targ(true,foursecond) end
	if spellname=="summon familiar" then UO.Macro(15,112) return end
	if spellname=="vampiric embrace" then UO.Macro(15,113) return end
	if spellname=="vengeful spirit" then UO.Macro(15,114) targ(true,foursecond) end
	if spellname=="wither" then UO.Macro(15,115) return end
	if spellname=="wraith form" then UO.Macro(15,116) return end
	if spellname=="exorcism" then UO.Macro(15,117) targ(true,foursecond) end

	--b=string.lower(UO.CharStatus) repeat until "a" ~=string.match(b, "a") return 
	if #arg>0 then
		if arg[1]=="self" then
			targetitem("self")
		else
			targetitem(arg[1])
		end
	end
--[[ necro spells	
UO.Macro(	15	,	101	)		--	Cast Spell [N] Animate Dead	
UO.Macro(	15	,	102	)		--	Cast Spell [N] Blood Oath	
UO.Macro(	15	,	103	)		--	Cast Spell [N] Corpse Skin	
UO.Macro(	15	,	104	)		--	Cast Spell [N] Curse Weapon	
UO.Macro(	15	,	105	)		--	Cast Spell [N] Evil Omen	
UO.Macro(	15	,	106	)		--	Cast Spell [N] Horrific Beast	
UO.Macro(	15	,	107	)		--	Cast Spell [N] Lich Form	
UO.Macro(	15	,	108	)		--	Cast Spell [N] Mind Rot	
UO.Macro(	15	,	109	)		--	Cast Spell [N] Pain Spike	
UO.Macro(	15	,	110	)		--	Cast Spell [N] Poison Strike	
UO.Macro(	15	,	111	)		--	Cast Spell [N] Strangle	
UO.Macro(	15	,	112	)		--	Cast Spell [N] Summon Familiar	
UO.Macro(	15	,	113	)		--	Cast Spell [N] Vampiric Embrace	
UO.Macro(	15	,	114	)		--	Cast Spell [N] Vengeful Spirit	
UO.Macro(	15	,	115	)		--	Cast Spell [N] Wither	
UO.Macro(	15	,	116	)		--	Cast Spell [N] Wraith Form	
UO.Macro(	15	,	117	)		--	Cast Spell [N] Exorcism	
]]
end
-------------------------------------------------------------------------------
function needash(needashed)
	if verbose then print("needash") end
	needashid3=ScanItems(true,{Type=hammtype,ContID=UO.CharID,Col=ancienthammcolor})
	if #needashid3>0 then Drag(needashid3[1].ID,needashid3[1].ContID,backpack) wait(onesecond) end
	needashid=ScanItems(true,{Type=hammtype,ContID=backpack,Col=ancienthammcolor})
	if #needashid<1 then 
		needashid2=ScanItems(true,{Type=hammtype,ContID=materialschestid,Col=ancienthammcolor})
		if #needashid2>0 then Drag(needashid2[1].ID,needashid2[1].ContID,backpack) wait(onesecond) end
	end
	needashid=ScanItems(true,{Type=hammtype,ContID=backpack,Col=ancienthammcolor})
	if needashed==true then
		UO.Equip(needashid[1].ID) wait(onesecond)
	end
end
-------------------------------------------------------------------------------
function open2easy (openID) -- 					From OpenEUO to EasyUO 
	verbose2("open2easy",penID)
   local easyID = "" 
   local i = (Bit.Xor(openID, 69) + 7) 

   while (i > 0) do 
      easyID = easyID .. string.char((i % 26) + string.byte('A')) 
      i = math.floor(i / 26) 
   end 
    
   return easyID 
end
-------------------------------------------------------------------------------
function opencontainers( ... ) --				opencontainers(chesttoopen) opencontainers(chesttoopen,screenx,screeny)
	verbose2("OpenContainers",arg[1])
	chesttoopen=arg[1]
	if type(chesttoopen)=="table" then
		if #chesttoopen>0 then
			for tempOpenContainers=1,#chesttoopen do
				curchestoopenid=chesttoopen[tempOpenContainers]
				repeat
					opened=false
					t = ScanConts({ID=curchestoopenid}) 
					for openalready=1,#t do
						if t[openalready].ID==curchestoopenid then UO.ContTop(t[openalready].Index) wait(tenthsecond) opened=true end
					end
					if opened==false then
						useobject(curchestoopenid)
						wait(onesecond)
					end
					if #arg==3 then
						UO.ContPosX=arg[2]
						UO.ContPosY=arg[3]
						wait(tenthsecond)
					end
				until UO.ContID==curchestoopenid
			end
		end
	end
	if type(chesttoopen)=="number" then
		useobject(chesttoopen)
		wait(onesecond)
		if #arg==3 then
			UO.ContPosX=arg[2]
			UO.ContPosY=arg[3]
			wait(tenthsecond)
		end
	end
end
-------------------------------------------------------------------------------
function parsebookname(bookname) --				bookid,maxrunes,houserune,blacksmithrune,tailorrune,bankrune=parsebookname(bookname)
	verbose2("parsebook",bookname)
	bbool,readfilestring=pcall(dofile,getinstalldir().."scripts/runebooks.txt")
	if bbool==false then writef(getinstalldir().."scripts/runebooks.txt", "return {}",false) end
		local bookfound=false
		repeat
			t=ScanItems(true,{Type=runebooktype})
			for ind=#t,0, -1 do
				local name,info=UO.Property(t[ind].ID)
				bookn=string.lower(bookname)	inf=string.lower(info)
				if bookn==string.match(inf, bookn) then 
					bookfound=true
					bookid=t[ind].ID
					if verbose==true then print("book: " ..bookid) end
					break
				end
			end
		until bookfound==true
	bbool,readfilestring=pcall(dofile,getinstalldir().."scripts/runebooks.txt")
	if tostring(bookid)==string.match(TableToString(readfilestring), tostring(bookid)) then
                maxrunes=#readfilestring[bookid]       
		for RuneSlot=1,maxrunes do
			temp=string.lower(readfilestring[bookid][RuneSlot])
			if houserune1name==string.match(temp, houserune1name) or houserune2name==string.match(temp, houserune2name) then
				table.insert(houserune,bookid .. "_" .. RuneSlot)
			end
			if blacksmithrune1name==string.match(temp, blacksmithrune1name) or blacksmithrune2name==string.match(temp, blacksmithrune2name) then
				table.insert(blacksmithrune,bookid .. "_" .. RuneSlot)
			end
			if tailorrune1name==string.match(temp, tailorrune1name) or tailorrune2name==string.match(temp, tailorrune2name) then
				table.insert(tailorrune,bookid .. "_" .. RuneSlot)
			end
			if bankrune1name==string.match(temp, bankrune1name) or bankrune2name==string.match(temp, bankrune2name) then
				table.insert(bankrune,bookid .. "_" .. RuneSlot)
			end
		end
		return bookid,maxrunes,houserune,blacksmithrune,tailorrune,bankrune
	else
		readfilestring[bookid]={}
		repeat useobject(bookid) wait(onesecond) until waitforgump("runebooksz",false)
		local maxrunes=KAL.GetRuneCount()
		for RuneSlot=1, maxrunes do
			local a=1 
			temp=KAL.GetRuneName(RuneSlot,UO.ContPosX,UO.ContPosY,"number")
			readfilestring[bookid][RuneSlot]=temp
			temp=string.lower(temp)
			if houserune1name==string.match(temp, houserune1name) or houserune2name==string.match(temp, houserune2name) then
				table.insert(houserune,bookid .. "_" .. RuneSlot)
			end
			if blacksmithrune1name==string.match(temp, blacksmithrune1name) or blacksmithrune2name==string.match(temp, blacksmithrune2name) then
				table.insert(blacksmithrune,bookid .. "_" .. RuneSlot)
			end
			if tailorrune1name==string.match(temp, tailorrune1name) or tailorrune2name==string.match(temp, tailorrune2name) then
				table.insert(tailorrune,bookid .. "_" .. RuneSlot)
			end
			if bankrune1name==string.match(temp, bankrune1name) or bankrune2name==string.match(temp, bankrune2name) then
				table.insert(bankrune,bookid .. "_" .. RuneSlot)
			end
		end
		if waitforgump("runebooksz",true) then clickxxyy(275,100,false,true,true,false) wait(thirdsecond) end
		writef(getinstalldir().."scripts/runebooks.txt", "return " .. TableToString(readfilestring),false)
		return bookid,maxrunes,houserune,blacksmithrune,tailorrune,bankrune
	end
end
-------------------------------------------------------------------------------
			function parsevendorbook(vendorbookname) --					Not working yet --vendorbookid,vendorrune=parsevendorbook(vendorbookname) 
	verbose2("parsevendorbook",vendorbookname)
	local vendorbookfound=false
	repeat
		local t=ScanItems(true,{Type=runebooktype})
		for ind=#t,0, -1 do
			local name,info=UO.Property(t[ind].ID)   
			if vendorbookname==string.match(info, vendorbookname) then 
				vendorbookfound=true
				vendorbookid=t[ind].ID
				if debug==true then print("vendor book: " ..vendorbookid) end
				break
			end
		end
	until vendorbookfound==true
	while contsz(452,236,false) do useobject(minebookid) wait(onesecond) end
	wait(onesecond)
	maxvendorrunes=KAL.GetRuneCount()
	for RuneSlot=1, maxvendorrunes do
		a=1 
		temp=KAL.GetRuneName(RuneSlot,UO.ContPosX,UO.ContPosY,"number")
		list=split(temp,"_")
		if #list==2 then
			vendorrune[RuneSlot]={[1]=list[1],[2]=list[2]}
		end
		if #list==4 then
			vendorrune[RuneSlot]={[1]=list[1],[2]=list[2],[3]=list[3],[4]=list[4]}
		end
	end
	if contsz(452,236,true) then clickxxyy(275,100,false,true,true,false) wait(tenthsecond) end
	return vendorbookid,vendorrune
end
-------------------------------------------------------------------------------
			function Pathfind(x,y,z) --									Not working yet
  local P=PathFinder()
  path = P:FindPath({UO.CharPosX,UO.CharPosY,UO.CharPosZ}, {x,y,z})
  if path == nil then return false end
  if path == "Error : Ending is not passable!" then print("Error : Ending is not passable!") return end
  if path == "Error : Start is not passable!" then print("Error : Start is not passable!") return end
  while P:Next() do end      
end 
-------------------------------------------------------------------------------
function pollbodbook(temppollid) --				count,name,info=pollbodbook(bodbookid)
	verbose2("pollbodbook",temppollid)
	name,info=UO.Property(temppollid)
	tempPollBookstempa=split(info,"\n")
	tempPollBookstempb=split(tempPollBookstempa[3], " ")
	count=tempPollBookstempb[4]
	count=tonumber(count)
	return count,name,info
end
-------------------------------------------------------------------------------
function pollbodbooks()	--						bodbooks=pollbodbooks()
	verbose2("pollbodbooks")
	junkbookcounttotal=0
	filledbookcounttotal=0
	swapbookcounttotal=0
	bodbooks={}
	tempPollBooks=ScanItems(true,{Type=bodbooktype})
	bodbooks["zfill"]={}
	for tempPollBooksindex=1,#tempPollBooks do
		temppollid=tempPollBooks[tempPollBooksindex].ID
		count,name,info=pollbodbook(temppollid)
		info=string.lower(info)	junkbookname=string.lower(junkbookname)	filledbookname=string.lower(filledbookname)	swapbookname=string.lower(swapbookname)
		table.insert(bodbooks,{ID=tempPollBooks[tempPollBooksindex].ID,ContID=tempPollBooks[tempPollBooksindex].ContID,count=count})
		if junkbookname==string.match(info, junkbookname) then
			junkbookcounttotal=junkbookcounttotal+count
			bodbooks[tempPollBooksindex].Name=junkbookname
			bodbooks["zfill"]["junkbookcounttotal"]=junkbookcounttotal
			if verbose then print(info) end
			if count>0 then
				bodbooks["zfill"]["junkbooktoworkon"]=tempPollBooks[tempPollBooksindex].ID
				bodbooks["zfill"]["junkbooktoworkonchestid"]=tempPollBooks[tempPollBooksindex].ContID
			end
			if count<250 then
				bodbooks["zfill"]["junkbooktoaddnew"]=tempPollBooks[tempPollBooksindex].ID
				bodbooks["zfill"]["junkbooktoaddnewchestid"]=tempPollBooks[tempPollBooksindex].ContID
			end
		end
		if filledbookname==string.match(info, filledbookname) then
			filledbookcounttotal=filledbookcounttotal+count
			bodbooks[tempPollBooksindex].Name=filledbookname
			bodbooks["zfill"]["filledbookcounttotal"]=filledbookcounttotal
			if verbose then print(info) end
			if count>0 then
				bodbooks["zfill"]["filledbooktohandin"]=tempPollBooks[tempPollBooksindex].ID
				bodbooks["zfill"]["filledbooktohandinchestid"]=tempPollBooks[tempPollBooksindex].ContID
			end
			if count<250 then
				bodbooks["zfill"]["filledbooktoplacecompletedbod"]=tempPollBooks[tempPollBooksindex].ID
				bodbooks["zfill"]["filledbooktoplacecompletedbodschestid"]=tempPollBooks[tempPollBooksindex].ContID
			end
		end
		if swapbookname==string.match(info, swapbookname) then
			swapbookcounttotal=swapbookcounttotal+count
			bodbooks[tempPollBooksindex].Name=swapbookname
			bodbooks["zfill"]["curswapbook"]=tempPollBooks[tempPollBooksindex].ID
			bodbooks["zfill"]["curswapchestid"]=tempPollBooks[tempPollBooksindex].ContID
		end
	end
	return bodbooks
end
-------------------------------------------------------------------------------
function popupselect(id,selection) --			popupselect(id,selection)
	verbose2("popupselect",id,selection)
	UO.Popup(id,0,20)
	wait(halfsecond)
	selectiony = 18 * selection + 4
	clickxxyy(38,selectiony)
	wait(thirdsecond)
end
-------------------------------------------------------------------------------
function protection()
	verbose2("protection")
	if OnBuffBar("protection")==false then 
		repeat 
			magespell("protection") 
		until OnBuffBar("Protection")~=false 
	end
end
-------------------------------------------------------------------------------
function putbodinbook(bookid) --				putbodinbook(bookid)
	verbose2("putbodinbook",bookid)
	newbod=ScanItems(true,{Type=bodtype,ContID=UO.BackpackID})
	if #newbod>0 then
		for newbodnum=1,#newbod do
			Drag(newbod[newbodnum].ID,backpack,bookid)
		end
		if contsz(620,459,true) then
			clickxxyy(389,428) 
			wait(tenthsecond)
		end
	end
end
-------------------------------------------------------------------------------
function readboddatetime() --					accountname,accountpassword,accountcharcount,accountnumber,returncharid,returncharnumber,oldhour,oldminute,oldsecond,olddate=readboddatetime()
	verbose2("readboddatetime")
    bA,getbodaccount=dofile(getinstalldir().."scripts/" .. accountsettingsfile)
    for a=1,getbodaccount["accounts"] do
        for charcount=1,getbodaccount[a]["charcount"] do
            chartest=(getbodaccount[a]["character" .. tostring(charcount)])
            chartest=tonumber(chartest)
            if UO.CharID==chartest then
				accountname=getbodaccount[a]["account"]
				accountpassword=getbodaccount[a]["password"]
				accountcharcount=getbodaccount[a]["charcount"]
				oldhour=getbodaccount[a]["bodhour"]
				oldminute=getbodaccount[a]["bodminute"]
				oldsecond=getbodaccount[a]["bodsecond"]
				olddate=getbodaccount[a]["boddate"]
				oldhour=tonumber(oldhour)
				oldminute=tonumber(oldminute)
				oldsecond=tonumber(oldsecond)
				olddate=tonumber(olddate)
				accountnumber=a
				returncharid=chartest
				returncharnumber=charcount
				return accountname,accountpassword,accountcharcount,accountnumber,returncharid,returncharnumber,oldhour,oldminute,oldsecond,olddate
            end
            
        end
    end
end
-------------------------------------------------------------------------------
function readf(filename) --						filestring=readf(filename)
	verbose2("readfile",filename)
	local file,mode=openfile(filename,"rb")
	filestring=file:read("*a")
	file:close()
	return filestring
end
-------------------------------------------------------------------------------
function railwriter() --						railwriter() alt-x to start, alt-x or dist>8 writes coords alt-y stops
	rail={}
	repeat
	until getkey("x",false,true,false)
	wait(twosecond)
	repeat
		a=UO.CharPosX .. "_" .. UO.CharPosY
		table.insert(rail,a)
		
		repeat
			dist=finddist(x,y)
		until dist>8 or getkey("x",false,true,false) or getkey("y",false,true,false)
	until getkey("y",false,true,false)
	writef(getinstalldir().."scripts\\lib\\rail.txt",rail,true)
	print(TableToString(rail))
end
-------------------------------------------------------------------------------
function recallto( ... ) --						bSuccess=recallto("house",method) --recallto("blacksmith",method) --recallto("tailor",method)  --recallto("bank",method) --recallto(bookid,runenumber,method)
	verbose2("recallto",arg)
	tempmovetospop=nil
	repeat
		loc=UO.CharPosX .. "_" .. UO.CharPosY
		travelmethod="Recall"
		
		if #arg>1 then 
			if "sacred"==string.match(string.lower(arg[2]), "sacred") or "journey"==string.match(string.lower(arg[2]), "journey") then travelmethod="SacredJourney" end
		end
		if #arg>2 then 
			if "sacred"==string.match(string.lower(arg[3]), "sacred") or "journey"==string.match(string.lower(arg[3]), "journey") then travelmethod="SacredJourney" end
		end

		if equipspellbookforrecall==true and travelmethod=="Recall" then equiptype("type",spellbooktype) end
		temphousebookid=arg[1] temprunenumber=arg[2] 
		if string.lower(arg[1])=="house" then
			print("house")
			rand=math.random(1,#houserune)
			temprunenumber=houserune[rand]
			asd=split(temprunenumber,"_")
			temprunenumber=tonumber(asd[2])
			temphousebookid=tonumber(asd[1])
			tempmovetospop=housemovetospot
			if UO.CharPosX .. "_" .. UO.CharPosY == housemovetospot[#housemovetospot] then return true end
		end
		if string.lower(arg[1])=="bods" then
			print("bods")
			rand=math.random(1,#houserune)
			temprunenumber=houserune[rand]
			asd=split(temprunenumber,"_")
			temprunenumber=tonumber(asd[2])
			temphousebookid=tonumber(asd[1])
			tempmovetospop=bodsmovetospot
			if UO.CharPosX .. "_" .. UO.CharPosY == bodsmovetospot[#bodsmovetospot] then return true end
		end
		if string.lower(arg[1])=="blacksmith" then
			print("blacksmith")
			rand=math.random(1,#blacksmithrune)
			temprunenumber=blacksmithrune[rand]
			asd=split(temprunenumber,"_")
			temprunenumber=tonumber(asd[2])
			temphousebookid=tonumber(asd[1])
			tempmovetospop=blacksmithmovetospot
			if UO.CharPosX .. "_" .. UO.CharPosY == blacksmithmovetospot[#blacksmithmovetospot] then return true end
		end
		if string.lower(arg[1])=="tailor" then
			print("tailor")
			rand=math.random(1,#tailorerune)
			temprunenumber=tailorrune[rand]
			asd=split(temprunenumber,"_")
			temprunenumber=tonumber(asd[2])
			temphousebookid=tonumber(asd[1])
			tempmovetospop=tailormovetospot
			if UO.CharPosX .. "_" .. UO.CharPosY == tailormovetospot[#tailormovetospot] then return true end
		end
		if string.lower(arg[1])=="bank" then
			print("bank")
			rand=math.random(1,#bankrune)
			temprunenumber=bankrune[rand]
			asd=split(temprunenumber,"_")
			temprunenumber=tonumber(asd[2])
			temphousebookid=tonumber(asd[1])
			tempmovetospop=bankmovetospot
			if UO.CharPosX .. "_" .. UO.CharPosY == bankmovetospot[#bankmovetospot] then return true end
		end
		try=RuneBook.Travel(temphousebookid, temprunenumber, travelmethod, 1)
	until loc~=UO.CharPosX .. "_" .. UO.CharPosY
	if tempmovetospop~=nil then moveto(tempmovetospop) end
	return true
end
-------------------------------------------------------------------------------
function returningots(materialschestid) --		returningots(materialschestid)
	verbose2("returningots",materialschestid)
	returningotstemp=ScanItems(true,{Type=ingottype,ContID=backpack})
	if #returningotstemp>0 then
		for returningotstempindex=1,#returningotstemp do
			ingid=returningotstemp[returningotstempindex].ID
			ingstack=returningotstemp[returningotstempindex].Stack
			UO.Drag(ingid,ingstack) wait(halfsecond)
			UO.DropC(materialschestid) wait(onesecond)
		end
	end
end
-------------------------------------------------------------------------------
function setcolor(cmenu)
	if verbose then print("setcolor" .." " ..cmenu) end
	clickxxyy(30,372) repeat wait(tick) until UO.ContName=="generic gump" and UO.ContSizeX==530 and UO.ContSizeY==497
	yy=cmenu * 20 + 50
	clickxxyy(236,yy) repeat wait(tick) until UO.ContName=="generic gump" and UO.ContSizeX==530 and UO.ContSizeY==497
end
-------------------------------------------------------------------------------
function settitle(title) --        				oldtitle,newtitle=settitle(newtitle)
	verbose2("Set UO Title",title)
	oldtitle=UO.CliTitle
	UO.CliTitle=title
	newtitle=UO.CliTitle
	return oldtitle,newtitle
end
-------------------------------------------------------------------------------
			function showcount( ... ) --								Not working yet
BitMap_Art={} 
CounterLeft=200  
Layer1 = Obj.Create("TForm") 
Layer1._ = {BorderStyle = 0,WindowState = 2,FormStyle = 3,Color = 0,TransparentColor = true,TransparentColorValue = 0} 
 
Counter_form = Obj.Create("TForm")        
Counter_form._={Caption = "Wesley's Counter!  ",Left=0,Top=0, Width=100, Height=350, OnClose = function() Obj.Exit() end} 
Counter_form.FormStyle = 3  
 
Canvas = Layer1.Canvas 
Pen = Canvas.Pen 
Brush = Canvas.Brush 
Canvas.Font.Name =  "Arial"  
Canvas.Font.Size =  12   
 
Count={} 
--[[Count={ 
{Type=3962,Stack=0}, 
{Type=3963,Stack=0},  
{Type=3972,Stack=0}, 
{Type=3973,Stack=0},  
{Type=3974,Stack=0}, 
{Type=3976,Stack=0},  
{Type=3980,Stack=0}, 
{Type=3981,Stack=0},   
{Type=3817,Stack=0},   
{Type=3853,Stack=0}, 
} 
]]

countindex=0
if type(arg[1]) == "string" then
	if arg[1] == "ingots" then
		Count[1]={Type=ingottype,Col=ingotcol["ir"],Stack=0,Max=10000000}
		Count[2]={Type=ingottype,Col=ingotcol["dc"],Stack=0,Max=10000000}
		Count[3]={Type=ingottype,Col=ingotcol["sh"],Stack=0,Max=10000000}
		Count[4]={Type=ingottype,Col=ingotcol["co"],Stack=0,Max=10000000}
		Count[5]={Type=ingottype,Col=ingotcol["br"],Stack=0,Max=10000000}
		Count[6]={Type=ingottype,Col=ingotcol["go"],Stack=0,Max=10000000}
		Count[7]={Type=ingottype,Col=ingotcol["ag"],Stack=0,Max=10000000}
		Count[8]={Type=ingottype,Col=ingotcol["ve"],Stack=0,Max=10000000}
		Count[9]={Type=ingottype,Col=ingotcol["va"],Stack=0,Max=10000000}
	end
else
	for cx=1,#arg-1 do
		if type(arg[cx])=="table" then
			for dx=1,#arg[cx] do
				countindex=countindex+1
				Count[countindex]={Type=arg[cx][dx],Stack=0,Max=10000000}
			end
		end
		if type(arg[cx])=="number" then
			countindex=countindex+1
			Count[countindex]={Type=arg[cx],Stack=0,Max=10000000}
		end
	end
end
debug2(Count)
for i=1,table.getn(Count) do 
    local ArtID=Count[i].Type 
    if not BitMap_Art[ArtID] then GetStaticArt(ArtID) BitMap_Art[ArtID] = Obj.Create('TBitmap') BitMap_Art[ArtID]._={Data = LoadData(getinstalldir().."Art.bmp"), Transparent = true, TransparentColor = 0 } end 
end 
 
  local nCnt=UO.ScanItems(false) 
   
  for i=0,nCnt-1 do 
    local nID,nType,nKind, nContID, x, y, z, nStack, nRep, nCol = UO.GetItem(i)  
    if nContID == UO.BackpackID then 
      for a=1,table.getn(Count) do 
        if Count[a].Type == nType then 
          Count[a].Stack = Count[a].Stack + nStack 
        end 
      end 
    end 
  end 
 
 
 
Labels={} 
for i = 1,table.getn(Count) do 
Labels[i] = Obj.Create("TLabel")   
Labels[i]._ = {Left=40, Top=-15 + i*15, Parent = Counter_form}  
Labels[i].Caption=tostring(Count[i].Stack ) 
end 
 
 
 
 
 
 
update=true 
Timer = Obj.Create("TTimer") 
Timer.Interval = 1000 
Timer.Enabled = true 
Timer.OnTimer = function()       
 
 
for i = 1,table.getn(Count) do 
  Count[i].Stack=0 
end 
 
 
 
  local nCnt=UO.ScanItems(false) 
  for i=0,nCnt-1 do 
    local nID,nType,nKind, nContID, x, y, z, nStack, nRep, nCol = UO.GetItem(i)  
    if nID and nContID == UO.BackpackID then 
      for a=1,table.getn(Count) do 
        if Count[a].Type == nType then 
          Count[a].Stack = Count[a].Stack + nStack 
        end 
      end 
       
    end 
  end 
  for i = 1,table.getn(Count) do if Labels[i].Caption~=tostring(Count[i].Stack) then update=true end end 
if update then 
 
  
   
   
  for i = 1,table.getn(Count) do 
    local Pc=math.sqrt((Count[i].Stack-0)/Count[i].Max)    
    local Pc2=math.sqrt(1-(Count[i].Stack)/Count[i].Max) 
    if Pc > 1 or Pc2 < 0 then Pc=1 Pc2=0 end 
    Pen.Color=255*(Pc2)+Bit.Shl(255*Pc,8)        
    --print(Pc..","..Pc2) 
    Brush.Color=Pen.Color 
     
    Labels[i].Color=Pen.Color 
    Labels[i].Font.Color=1 
    Canvas.Rectangle(CounterLeft+60*i,0,CounterLeft+60+60*i,22)    
    Pen.Color=1 
    Canvas.Line(CounterLeft+60*i,0,CounterLeft+60*i,22) 
   
   
    pcall(Canvas.Draw,(CounterLeft+20-BitMap_Art[Count[i].Type].Width/2)+60*i,2,0,BitMap_Art[Count[i].Type])  
 
    Labels[i].Caption=tostring(Count[i].Stack) 
    Canvas.Font.Color=2 
    Canvas.Text(CounterLeft+40+60*i,0,Labels[i].Caption) 
  end 
  Pen.Color=0       
  Brush.Color=Pen.Color 
  Canvas.Rectangle(CounterLeft,23,CounterLeft+60+60*table.getn(Count),25)    
  update=false 
end 
 
         
end 
Counter_form.Show()    
Layer1.Show() 
 
Obj.Loop() 
for i=1,table.getn(Count) do 
  Obj.Free(Labels[i])  
end 
Obj.Free(Counter_form) 
  Layer1.Hide()      
  Obj.Free(Layer1)
end
-------------------------------------------------------------------------------
function smeltitem(smelttarget) --				smeltitem(smelttarget)
	verbose2("smeltitem",smelttarget)
	usetool("tong")
	clickxxyy(30,352) 
	targetitem(smelttarget)
	repeat wait(tick) until waitforgump("tongsz",true)
end
-------------------------------------------------------------------------------
function smelton(smeltonlocation) --			smelton("beetle" or "forge")
	verbose2("smelt",smeltonlocation)
	if smeltonlocation=="beetle" then
		repeat
			qtemp=ScanItems(true,{Type=firebeetletype})
			for cnt=1,#qtemp do
				if qtemp[cnt].ID==firebeetle then
					nX=qtemp[cnt].X nY=qtemp[cnt].Y
					findxy=finddist(nX,nY)
				end
			end
			if findxy > 2 then
				UO.Msg("all follow me" .. string.char(13))
				wait(onesecond)
			end
			qtemp=ScanItems(true,{Type=firebeetletype})
			for cnt=1,#qtemp do
				if qtemp[cnt].ID==firebeetle then
					nX=qtemp[cnt].X nY=qtemp[cnt].Y
					findxy=finddist(nX,nY)
				end
			end
		until findxy < 3
		TargetID=firebeetle
		TargetKind=1
	end
	if smeltonlocation=="forge" then			
		qtemp=ScanItems(true,{Type=forgetype})
		for cnt=1,#qtemp do
			nX=qtemp[cnt].X nY=qtemp[cnt].Y
			findxy=finddist(nX,nY)
			if findxy<3 then
				TargetID=qtemp[cnt].ID
				TargetKind=1
				break
			end
		end
	end
	repeat
		UO.LTargetID=TargetID
		UO.LTargetKind=TargetKind
		currore=ScanItems(true,{Type=oretype},{Type=tinyoretype,Stack=1})
			if #currore>0 then
				UO.LObjectID=currore[1].ID
				UO.Macro(17,0)
				targetitem(TargetID)
				wait(onesecond)
			end
	until #currore<1
end
-------------------------------------------------------------------------------
function spellweavingspell(spellname,...) --	spellweavingspell(spell)  spellweavingspell(spell,targetid)
	verbose2("spellweavingspell",spellname)
	string.lower(spellname)
	if spellname=="arcane circle" then UO.Macro(15,6) return end
	if spellname=="gift of renewal" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="immolating weapon" then UO.Macro(15,6) return end
	if spellname=="attunement" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="thunderstorm" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="nature's fury" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="summon fey" then UO.Macro(15,6) return end
	if spellname=="summon fiend" then UO.Macro(15,6) return end
	if spellname=="reaper form" then UO.Macro(15,6) return end
	if spellname=="wildfire" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="essence of wind" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="dryad allure" then UO.Macro(15,6) return end
	if spellname=="ethereal voyage" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="word of death" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="gift of life" then UO.Macro(15,6) targ(true,foursecond) end
	if spellname=="arcane empowerment" then UO.Macro(15,6) targ(true,foursecond) end

	--b=string.lower(UO.CharStatus) repeat until "a" ~=string.match(b, "a") return 
	if #arg>0 then
		if arg[1]=="self" then
			targetitem("self")
		else
			targetitem(arg[1])
		end
	end
--[[ spellweaving spells	
UO.Macro(	15	,	601	)		--	Cast Spell [SW] 	
UO.Macro(	15	,	602	)		--	Cast Spell [SW] 	
UO.Macro(	15	,	603	)		--	Cast Spell [SW] 	
UO.Macro(	15	,	604	)		--	Cast Spell [SW] Attunement	
UO.Macro(	15	,	605	)		--	Cast Spell [SW] Thunderstorm	
UO.Macro(	15	,	606	)		--	Cast Spell [SW] Nature's Fury	
UO.Macro(	15	,	607	)		--	Cast Spell [SW] Summon Fey	
UO.Macro(	15	,	608	)		--	Cast Spell [SW] Summon Fiend	
UO.Macro(	15	,	609	)		--	Cast Spell [SW] Reaper Form	
UO.Macro(	15	,	610	)		--	Cast Spell [SW] Wildfire	
UO.Macro(	15	,	611	)		--	Cast Spell [SW] Essence of Wind	
UO.Macro(	15	,	612	)		--	Cast Spell [SW] Dryad Allure	
UO.Macro(	15	,	613	)		--	Cast Spell [SW] Ethereal Voyage	
UO.Macro(	15	,	614	)		--	Cast Spell [SW] Word of Death	
UO.Macro(	15	,	615	)		--	Cast Spell [SW] Gift of Life	
UO.Macro(	15	,	616	)		--	Cast Spell [SW] Arcane Empowerment	
]]
end
-------------------------------------------------------------------------------
function soscoords(sosid)  --					sosx,sosy=soscoords()
	useobject(sosid) 
	waitforgump("sossz",true)
	x=UO.ContPosX+35 y=UO.ContPosY+240
	verbose2("soscoords",x,y)
	sosxy=""
	deg1=KAL.TextScan(x, y, "in", 524288, number,"       ")
	deg2=KAL.TextScan(x, y, "in", 524288, number,"       ")
	if deg1~=deg2 then return false,false end
	degxy=stringreplace(deg," ") degxy=stringreplace(degxy,"O","0") degxy=split(degxy,",") degy=degxy[1] degx=degxy[2] 
	ns=split(degy,"o") 
	nsleft=tonumber(ns[1]) ns=split(ns[2],"'")
	nsmid=tonumber(ns[1])
	nsright=ns[2]
	we=split(degx,"o")
	weleft=tonumber(we[1]) we=split(we[2],"'")
	wemid=tonumber(we[1])
	weright=we[2]
	nsnum=tonumber(nsleft) * 60 + tonumber(nsmid) 
	wenum=tonumber(weleft) * 60 + tonumber(wemid)
	wenum=wenum*100000
	nsnum=nsnum*10000000
	wenum=wenum/421878
	nsnum=nsnum/52734375
	if weright=="W" then 
		wenum=1323-wenum
		if wenum<0 then wenum=wenum+5120 end
	end
	if weright=="E" then 
		wenum=1323+wenum
		if wenum>5119 then wenum=wenum-5120 end
	end
	if nsright=="N" then 
		nsnum=1624-nsnum
		if nsnum<0 then nsnum=nsnum+4096 end
	end 
	if nsright=="S" then 
		nsnum=1624+nsnum 
		if nsnum>4095 then nsnum=nsnum-4096 end
	end
	sosy=math.floor(nsnum)
	sosx=math.floor(wenum)
	if sosx<9 then sosx=9 end
	if sosy<9 then sosy=9 end
	clickxxyy(70,70,false,true,true,false)
	waitforgump("sossz",false)
	return sosx,sosy
end
-------------------------------------------------------------------------------
function split(pString, pPattern) --			t=split(pString, pPattern) --seperates a pString based on pPattern and returns it in a table
	verbose2("split",pString, pPattern)
	t={} 
	for s in (pString..pPattern):gmatch("(.-)"..pPattern) do
		if s~="" then
			table.insert(t,s)
		end
	end
	return t
end
-------------------------------------------------------------------------------
function stringreplace(String,pattern, ... ) -- sString=stringreplace(String,pattern) sString=stringreplace(String,pattern,replacement)
	verbose2("stringreplace",String,pattern)
	if #arg<1 then
		sString=string.gsub(String, pattern, "") 
	else
		sString=string.gsub(String, pattern, arg[1]) 
	end	
	return sString
end
-------------------------------------------------------------------------------
function SubGetBods()
	accountname,accountpassword,accountcharcount,accountnumber,returncharid,returncharnumber,oldhour,oldminute,oldsecond,olddate=readboddatetime()
	secs=timetoseconds(oldhour,oldminute,oldsecond)
	oldsecs=secs
	nYear,nMonth,nDay,nDayOfWeek = getdate() nHour,nMinute,nSecond,nMillisec = gettime() hour=nHour minute=nMinute second=nSecond timetoseconds(nHour,nMinute,nSecond)
	newsecs=secs
	olddate=(olddate)
	newdate=tonumber(nYear .. nMonth .. nDay)
	if olddate<newdate then
	   secsdiff=newsecs-oldsecs + 86400
	else
		secsdiff=newsecs-oldsecs
	end
	if secsdiff < (3600 * HoursBetweenGettingBods) then
	   return
	end
	for curcharacter=1,accountcharcount do
		getbodsforcurchar=getbodaccount[accountnumber]["character" .. curcharacter .. "getbods"]
		if getbodsforcurchar==true then
			if UO.CliLogged then
				logout()     
			end
			method=getbodaccount[accountnumber]["character" .. curcharacter .. "method"]
			loginid=getbodaccount[accountnumber]["character" .. curcharacter]
			login(accountname,accountpassword,curcharacter,loginid)
			houserune={} blacksmithrune={} tailorrune={} bankrune={}
			bookid,maxrunes,houserune,blacksmithrune,tailorrune,bankrune=parsebookname(housebookname)
			if getblacksmithbods==true then 
				recallto("blacksmith",method)
				vendorfound,vendorid=findvendor("blacksmith","armourer")
				if vendorfound then	popupselect(vendorid,2) end
				if UO.ContName=="generic gump" then clickxxyy(117,UO.ContSizeY-30) wait(thirdsecond) end
			end
			if gettailorbods==true then 
				recallto("tailor",method)
				vendorfound,vendorid=findvendor("tailor")
				if vendorfound then	popupselect(vendorid,2) end
				if UO.ContName=="generic gump" then clickxxyy(117,UO.ContSizeY-30) wait(thirdsecond) end
			end
			recallto("bods",method)
			opencontainers(junkchestids)
			bodbooks=pollbodbooks()
			Drag(bodbooks["zfill"]["junkbooktoaddnew"],bodbooks["zfill"]["junkbooktoaddnewchestid"],UO.BackpackID)
			putbodinbook(bodbooks["zfill"]["junkbooktoaddnew"])
			Drag(bodbooks["zfill"]["junkbooktoaddnew"],UO.BackpackID,bodbooks["zfill"]["junkbooktoaddnewchestid"])
		end
	end
	writeboddatetime(accountnumber,accountsettingsfile)
		   if UO.CliLogged then
			  logout()     
		   end
	login(accountname,accountpassword,returncharnumber,returncharid)
	return
end
-------------------------------------------------------------------------------
function targ(bbool, ... ) --					bool=targ(true,onesecond)
	waittime=twosecond
	if #arg>0 then waittime=arg[1] end
	verbose2("targ",bbool,waittime)
	local timex=getticks() + waittime
	repeat wait(tick) until timex < getticks() or UO.TargCurs==bbool
	return UO.TargCurs
end
-------------------------------------------------------------------------------
function targetitem(targedid, ... )  --			targetitem(targedid)
	waittime=twosecond
	if #arg>0 then waittime=arg[1] end
	verbose2("targetitem",targedid,waittime)
	targ(true,waittime)
	if targedid=="self" then 
		UO.LTargetID=UO.CharID
	else
		UO.LTargetID=targedid
	end
	UO.LTargetKind=1
	UO.Macro(22,0)
	targ(false,tenthsecond)
end
-------------------------------------------------------------------------------
function timetoseconds(hour,minute,second) --	seconds=timetoseconds(hour,minute,second)
	verbose2("timetoseconds",hour,minute,second)
         secs=(hour * 3600) + (minute * 60) + (second)
         return secs
end
-------------------------------------------------------------------------------
function useitemxyz(item,spotx,spoty,spotz,spottype,spotkind)  --useitemxyz(itemid,spotx,spoty,spotz,spottype,spotkind)
	verbose2("useitemxyz",item,spotx,spoty,spotz,spottype,spotkind)
	UO.LTargetX=spotx
	UO.LTargetY=spoty
	UO.LTargetZ=spotz
	UO.LTargetTile=spottype
	UO.LTargetKind=spotkind
	Journal.Mark()
	if type(item)== "string" then usetool(item) else useobject(item) targ(true) end
	UO.Macro(22,0)
	targ(false,4000)
	wait(onesecond)
end
-------------------------------------------------------------------------------
function useobject(useobjectid) --				useobject(useobjectid)
	verbose2("useobject",useobjectid)
	UO.LObjectID=useobjectid 
	UO.Macro(17,0)
end
-------------------------------------------------------------------------------
function usetool(tool) --						usetool("shovel")  ,  usetool("tink")  ,  usetool("tong")
	verbose2("usetool",tool)
	if tool=="shovel" then
		repeat
			useitem=ScanItems(true,{Type=shoveltype,ContID=backpack})
			if #useitem<2 then maketool("shovel") end
			useitem=ScanItems(true,{Type=shoveltype,ContID=backpack})
		until #useitem>0
		useobject(useitem[#useitem].ID)
		targ(true)
	end
	if tool=="tink" then
		repeat
			useitem=ScanItems(true,{Type=tinkertooltype,ContID=backpack})
			if #useitem<2 then maketool("tink") end
			useitem=ScanItems(true,{Type=tinkertooltype,ContID=backpack})
		until #useitem>1
		repeat
		useobject(useitem[#useitem].ID)
		until waitforgump("tinksz",true)
	end
	if tool=="tong" then
		repeat
			useitem=ScanItems(true,{Type=tongstype,ContID=backpack})
			if #useitem<2 then maketool("tong") end
			useitem=ScanItems(true,{Type=tongstype,ContID=backpack})
		until #useitem>0
		repeat
		useobject(useitem[#useitem].ID)
		until waitforgump("tongsz",true)
	end
end
-------------------------------------------------------------------------------
function verbose2( ... ) --						verbose2(a,b,c,d,e,f,g, ...) 
	if verbose==true then
		debugtext=""
		for argi=1,#arg do
			if type(arg[argi])~="table" then
				debugtext=debugtext .. tostring(arg[argi]) .. "|"
			else
				debugtext=debugtext .. TableToString(arg[argi]) .. "|"
			end
		end
		print(debugtext)
	end
end
-------------------------------------------------------------------------------
function waitformana(n) --						waitformana(n) 
	verbose2("waitformana",n)
	repeat wait(tick) until UO.Mana == n
end
-------------------------------------------------------------------------------
function waitformove(timer) --					moved=waitformove(timer)
	local oldx=UO.CharPosX 
	local oldy=UO.CharPosY
	local timex=getticks() + timer 
	repeat wait(tick) 
		if timex < getticks() then 
			return false 
		end 
	until oldx~=UO.CharPosX or oldy~=UO.CharPosY
	return true
end
-------------------------------------------------------------------------------
function waitforgump(gumpname,bIsisnt)  --		waitforgump("backpacksz",bIsisnt)
	gumpx=gumps[gumpname]["szx"]
	gumpy=gumps[gumpname]["szy"]
	gumpname2=gumps[gumpname]["name"]
	verbose2("waitforgump",gumpname,bIsisnt,gumpx,gumpy,gumpname2)
	timex=getticks() + foursecond
	if bIsisnt~=false then
		repeat
		if gumpx==0 and UO.ContSizeY==gumpy and UO.ContName==gumpname2 then return true end
		if UO.ContSizeX==gumpx and gumpy==0 and UO.ContName==gumpname2 then return true end
		if UO.ContSizeX==gumpx and UO.ContSizeY==gumpy and UO.ContName==gumpname2 then return true end
		until timex < getticks()
		return false
	else
		repeat
		if gumpx==0 and UO.ContSizeY~=gumpy or UO.ContName==gumpname2 then return true end
		if UO.ContName==gumpname2 or UO.ContSizeX~=gumpx and gumpy==0 then return true end
		if UO.ContSizeX~=gumpx or UO.ContSizeY~=gumpy or UO.ContName~=gumpname2 then return true end
		until timex < getticks()
		return false
	end
	return false
end
-------------------------------------------------------------------------------
function weightcheck(diff) -- 						weightok=weightcheck(50)
	if UO.Weight > UO.MaxWeight - diff then 
		return false
	else	
		return true
	end
end
-------------------------------------------------------------------------------
function writeboddatetime(accountnumber,accountsettingsfile) --writeboddatetime(accountnumber,accountsettingsfile)
		verbose2("writeboddatetime",accountnumber,accountsettingsfile)
        bA,data=dofile(getinstalldir().."scripts\\" .. accountsettingsfile)
        nYear,nMonth,nDay,nDayOfWeek = getdate() 
        nHour,nMinute,nSecond,nMillisec = gettime() 
        year=nYear
        month=nMonth
        day=nDay
        hour=nHour
        minute=nMinute
        second=nSecond
        bdate=(year .. month .. day)
        data[accountnumber]["boddate"]=bdate 
        data[accountnumber]["bodhour"]=hour
        data[accountnumber]["bodminute"]=minute
        data[accountnumber]["bodsecond"]=second
        filename=(getinstalldir().."scripts\\" .. accountsettingsfile)
        data=("return true," .. TableToString(data))
        append=false
        writef(filename,data,false)
end
-------------------------------------------------------------------------------
function writef(filename,data,append) --		writef(sFilename,data,bAppend)
	if append==true then
		file,mode=openfile(filename,"a+b")
		print("append")
	else
		file,mode=openfile(filename,"w+b")
		print("write")
	end
	file:write(data)
	file:close()
end
-------------------------------------------------------------------------------
--[[
slib.slredirect('in')
local f = function() 
  local a  = {} 
  a = a + 1 
end
local h = function(eref)
  local le = eref
  if type(le) == 'string' then
    error(le,1)
  end
end
local _type,_errid,_errname,_errmsg,_probe  = slib.try(f,h)
pause()
print(_type)
print(_errid)
print(_errname)
print(_errmsg)
print(_probe) 
print(tostring(slib.geterror(d)._errmsg))

pause()
pause()
pause()
]]
-------------------------------------------------------------------------------
--[[ Macros
UO.Macro(	1	,	0	msg text	)	--	Say	
UO.Macro(	2	,	0	msg text	)	--	Emote	
UO.Macro(	3	,	0	msg text	)	--	Whisper	
UO.Macro(	4	,	4	msg text	)	--	Yell	
UO.Macro(	5	,	0	)		--	Walk North West	
UO.Macro(	5	,	1	)		--	Walk North	
UO.Macro(	5	,	2	)		--	Walk North East	
UO.Macro(	5	,	3	)		--	Walk East	
UO.Macro(	5	,	4	)		--	Walk South East	
UO.Macro(	5	,	5	)		--	Walk South	
UO.Macro(	5	,	6	)		--	Walk South West	
UO.Macro(	5	,	7	)		--	Walk West	
UO.Macro(	6	,	0	)		--	Toggle War/Peace	
UO.Macro(	7	,	0	)		--	Paste	
UO.Macro(	8	,	0	)		--	Open Configuration	
UO.Macro(	8	,	1	)		--	Open Paperdoll	
UO.Macro(	8	,	2	)		--	Open Status	
UO.Macro(	8	,	3	)		--	Open Journal	
UO.Macro(	8	,	4	)		--	Open Skills	
UO.Macro(	8	,	5	)		--	Open Spellbook	
UO.Macro(	8	,	6	)		--	Open Chat	
UO.Macro(	8	,	7	)		--	Open Backpack	
UO.Macro(	8	,	8	)		--	Open Overview	
UO.Macro(	8	,	9	)		--	Open Mail	
UO.Macro(	8	,	10	)		--	Open Party Manifest	
UO.Macro(	8	,	11	)		--	Open Party Chat	
UO.Macro(	8	,	12	)		--	Open Necro Spellbook	
UO.Macro(	8	,	13	)		--	Open Paladin Spellbook	
UO.Macro(	8	,	14	)		--	Open Combat Book	
UO.Macro(	8	,	15	)		--	Open Bushido Spellbook	
UO.Macro(	8	,	16	)		--	Open Ninjutsu Spellbook	
UO.Macro(	8	,	17	)		--	Open Guild	
UO.Macro(	8	,	18	)		--	Open Spellweaving SpellBook	
UO.Macro(	8	,	19	)		--	Open Questlog	
UO.Macro(	9	,	0	)		--	Close Configuration	
UO.Macro(	9	,	1	)		--	Close Paperdoll	
UO.Macro(	9	,	2	)		--	Close Status	
UO.Macro(	9	,	3	)		--	Close Journal	
UO.Macro(	9	,	4	)		--	Close Skills	
UO.Macro(	9	,	5	)		--	Close Spellbook	
UO.Macro(	9	,	6	)		--	Close Chat	
UO.Macro(	9	,	7	)		--	Close Backpack	
UO.Macro(	9	,	8	)		--	Close Overview	
UO.Macro(	9	,	9	)		--	Close Mail	
UO.Macro(	9	,	10	)		--	Close Party Manifest	
UO.Macro(	9	,	11	)		--	Close Party Chat	
UO.Macro(	9	,	12	)		--	Close Necro Spellbook	
UO.Macro(	9	,	13	)		--	Close Paladin Spellbook	
UO.Macro(	9	,	14	)		--	Close Combat Book	
UO.Macro(	9	,	15	)		--	Close Bushido Spellbook	
UO.Macro(	9	,	16	)		--	Close Ninjutsu Spellbook	
UO.Macro(	9	,	17	)		--	Close Guild	
UO.Macro(	10	,	1	)		--	Minimize Paperdoll	
UO.Macro(	10	,	2	)		--	Minimize Status	
UO.Macro(	10	,	3	)		--	Minimize Journal	
UO.Macro(	10	,	4	)		--	Minimize Skills	
UO.Macro(	10	,	5	)		--	Minimize Spellbook	
UO.Macro(	10	,	6	)		--	Minimize Chat	
UO.Macro(	10	,	7	)		--	Minimize Backpack	
UO.Macro(	10	,	8	)		--	Minimize Overview	
UO.Macro(	10	,	9	)		--	Minimize Mail	
UO.Macro(	10	,	10	)		--	Minimize Party Manifest	
UO.Macro(	10	,	11	)		--	Minimize Party Chat	
UO.Macro(	10	,	12	)		--	Minimize Necro Spellbook	
UO.Macro(	10	,	13	)		--	Minimize Paladin Spellbook	
UO.Macro(	10	,	14	)		--	Minimize Combat Book	
UO.Macro(	10	,	15	)		--	Minimize Bushido Spellbook	
UO.Macro(	10	,	16	)		--	Minimize Ninjutsu Spellbook	
UO.Macro(	10	,	17	)		--	Minimize Guild	
UO.Macro(	11	,	1	)		--	Maximize Paperdoll	
UO.Macro(	11	,	2	)		--	Maximize Status	
UO.Macro(	11	,	3	)		--	Maximize Journal	
UO.Macro(	11	,	4	)		--	Maximize Skills	
UO.Macro(	11	,	5	)		--	Maximize Spellbook	
UO.Macro(	11	,	6	)		--	Maximize Chat	
UO.Macro(	11	,	7	)		--	Maximize Backpack	
UO.Macro(	11	,	8	)		--	Maximize Overview	
UO.Macro(	11	,	9	)		--	Maximize Mail	
UO.Macro(	11	,	10	)		--	Maximize Party Manifest	
UO.Macro(	11	,	11	)		--	Maximize Party Chat	
UO.Macro(	11	,	12	)		--	Maximize Necro Spellbook	
UO.Macro(	11	,	13	)		--	Maximize Paladin Spellbook	
UO.Macro(	11	,	14	)		--	Maximize Combat Book	
UO.Macro(	11	,	15	)		--	Maximize Bushido Spellbook	
UO.Macro(	11	,	16	)		--	Maximize Ninjutsu Spellbook	
UO.Macro(	11	,	17	)		--	Maximize Guild	
UO.Macro(	12	,	0	)		--	Opendoor	
UO.Macro(	13	,	1	)		--	Use Skill Anatomy	
UO.Macro(	13	,	2	)		--	Use Skill Animal Lore	
UO.Macro(	13	,	35	)		--	Use Skill Animal Taming	
UO.Macro(	13	,	4	)		--	Use Skill Arms Lore	
UO.Macro(	13	,	6	)		--	Use Skill Begging	
UO.Macro(	13	,	12	)		--	Use Skill Cartography	
UO.Macro(	13	,	14	)		--	Use Skill Detecting Hidden	
UO.Macro(	13	,	15	)		--	Use Skill Discordance	
UO.Macro(	13	,	16	)		--	Use Skill Evaluating Intelligence	
UO.Macro(	13	,	19	)		--	Use Skill Forensic Evaluation	
UO.Macro(	13	,	21	)		--	Use Skill Hiding	
UO.Macro(	13	,	23	)		--	Use Skill Inscription	
UO.Macro(	13	,	3	)		--	Use Skill Item Identification	
UO.Macro(	13	,	46	)		--	Use Skill Meditation	
UO.Macro(	13	,	9	)		--	Use Skill Peacemaking	
UO.Macro(	13	,	30	)		--	Use Skill Poisoning	
UO.Macro(	13	,	22	)		--	Use Skill Provocation	
UO.Macro(	13	,	48	)		--	Use Skill Remove Trap	
UO.Macro(	13	,	32	)		--	Use Skill Spirit Speak	
UO.Macro(	13	,	33	)		--	Use Skill Stealing	
UO.Macro(	13	,	47	)		--	Use Skill Stealth	
UO.Macro(	13	,	36	)		--	Use Skill Taste Identification	
UO.Macro(	13	,	38	)		--	Use Skill Tracking	
UO.Macro(	14	,	0	)		--	Last Skill	

UO.Macro(	15	,	145	)		--	Cast Spell [B] Honorable Execution	
UO.Macro(	15	,	146	)		--	Cast Spell [B] Confidence	
UO.Macro(	15	,	147	)		--	Cast Spell [B] Evasion	
UO.Macro(	15	,	148	)		--	Cast Spell [B] Counter Attack	
UO.Macro(	15	,	149	)		--	Cast Spell [B] Lightning Strike	
UO.Macro(	15	,	150	)		--	Cast Spell [B] Momentum Strike	
UO.Macro(	15	,	201	)		--	Cast Spell [C] Cleanse By Fire	
UO.Macro(	15	,	202	)		--	Cast Spell [C] Close Wounds	
UO.Macro(	15	,	203	)		--	Cast Spell [C] Consecrate Weapon	
UO.Macro(	15	,	204	)		--	Cast Spell [C] Dispel Evil	
UO.Macro(	15	,	205	)		--	Cast Spell [C] Divine Fury	
UO.Macro(	15	,	206	)		--	Cast Spell [C] Enemy Of One	
UO.Macro(	15	,	207	)		--	Cast Spell [C] Holy Light	
UO.Macro(	15	,	208	)		--	Cast Spell [C] Noble Sacrifice	
UO.Macro(	15	,	209	)		--	Cast Spell [C] Remove Curse	
UO.Macro(	15	,	210	)		--	Cast Spell [C] Sacred Journey	
UO.Macro(	15	,	245	)		--	Cast Spell [NI] Focus Attack	
UO.Macro(	15	,	246	)		--	Cast Spell [NI] Death Strike	
UO.Macro(	15	,	247	)		--	Cast Spell [NI] Animal Form	
UO.Macro(	15	,	248	)		--	Cast Spell [NI] Ki Attack	
UO.Macro(	15	,	249	)		--	Cast Spell [NI] Surprise Attack	
UO.Macro(	15	,	250	)		--	Cast Spell [NI] Backstab	
UO.Macro(	15	,	251	)		--	Cast Spell [NI] Shadowjump	
UO.Macro(	15	,	252	)		--	Cast Spell [NI] Mirror Image	

UO.Macro(	16	,	0	)		--	Last Spell	
UO.Macro(	17	,	0	)		--	Last Object	
UO.Macro(	18	,	0	)		--	Bow	
UO.Macro(	19	,	0	)		--	Salute	
UO.Macro(	20	,	0	)		--	Quit Game	
UO.Macro(	21	,	0	)		--	All Names	
UO.Macro(	22	,	0	)		--	Last Target	
UO.Macro(	23	,	0	)		--	Target Self	
UO.Macro(	24	,	1	)		--	Arm/Disarm Left	
UO.Macro(	24	,	2	)		--	Arm/Disarm Right	
UO.Macro(	25	,	0	)		--	Wait For Target	
UO.Macro(	26	,	0	)		--	Target Next	
UO.Macro(	27	,	0	)		--	Attack Last	
UO.Macro(	28	,	0	)		--	Delay	
UO.Macro(	29	,	0	)		--	Circletrans	
UO.Macro(	31	,	0	)		--	Close Gumps	
UO.Macro(	32	,	0	)		--	Always Run	
UO.Macro(	33	,	0	)		--	Save Desktop	
UO.Macro(	34	,	0	)		--	Kill Gump Open	
UO.Macro(	35	,	0	)		--	Primary Ability	
UO.Macro(	36	,	0	)		--	Secondary Ability	
UO.Macro(	37	,	0	)		--	Equip Last Weapon	
UO.Macro(	38	,	0	)		--	Set Update Range	
UO.Macro(	39	,	0	)		--	Modify Update Range	
UO.Macro(	40	,	0	)		--	Increase Update Range	
UO.Macro(	41	,	0	)		--	Decrease Update Range	
UO.Macro(	42	,	0	)		--	Maximum Update Range	
UO.Macro(	43	,	0	)		--	Minimum Update Range	
UO.Macro(	44	,	0	)		--	Default Update Range	
UO.Macro(	45	,	0	)		--	Update Update Range	
UO.Macro(	46	,	0	)		--	Enable Update Range Color	
UO.Macro(	47	,	0	)		--	Disable Update Range Color	
UO.Macro(	48	,	0	)		--	Toggle Update Range Color	
UO.Macro(	49	,	1	)		--	Invoke Honor Virtue	
UO.Macro(	49	,	2	)		--	Invoke Sacrifice Virtue	
UO.Macro(	49	,	3	)		--	Invoke Valor Virtue	
UO.Macro(	49	,	4	)		--	Invoke Compassion Virtue (Does Nothing)	
UO.Macro(	49	,	5	)		--	Invoke *1 Virtue	
UO.Macro(	49	,	6	)		--	Invoke *1 Virtue	
UO.Macro(	49	,	7	)		--	Invoke Justice Protection	
UO.Macro(	49	,	8	)		--	Invoke *1 Virtue	
UO.Macro(	50	,	1	)		--	select next 1-5	
UO.Macro(	51	,	1	)		--	select previous 1-5	
UO.Macro(	52	,	1	)		--	select nearest 1-5	
UO.Macro(	53	,	0	)		--	attack selected	
UO.Macro(	54	,	0	)		--	use selected	
UO.Macro(	55	,	0	)		--	current target	
UO.Macro(	56	,	0	)		--	targeting system on/off	
UO.Macro(	57	,	0	)		--	toggle buff window (open/close)	
UO.Macro(	58	,	0	)		--	bandage self	
UO.Macro(	59	,	0	)		--	bandage target	
]]
--[[ CharStatus
Value  Description  
C  Character is poisoned.  
H  Character is hidden.  
B  Character is female.  
G  Character is in war mode.  
D  Character is affected with lethal strike.  
A  Character is frozen (actively casting a spell / Waiting for transport after using help-menu) . 
]]
-------------------------------------------------------------------------------
UO.DropC(UO.BackpackID)
DavesLoaded=true
print("Library loaded")
