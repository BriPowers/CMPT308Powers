DROP TABLE IF EXISTS Players
CASCADE;
DROP TABLE IF EXISTS DMs
CASCADE;
DROP TABLE IF EXISTS PCs
CASCADE;
DROP TABLE IF EXISTS Played_By
CASCADE;
DROP TABLE IF EXISTS NPCs
CASCADE;
DROP TABLE IF EXISTS Chars
CASCADE;
DROP TABLE IF EXISTS Equipped_Items
CASCADE;
DROP TABLE IF EXISTS Abilities
CASCADE;
DROP TABLE IF EXISTS Skills
CASCADE;
DROP TABLE IF EXISTS Spells
CASCADE;
DROP TABLE IF EXISTS Adventures
CASCADE;
DROP TABLE IF EXISTS Encounters
CASCADE;
DROP TABLE IF EXISTS Fight_In
CASCADE;
DROP TABLE IF EXISTS Combat_Info
CASCADE;



create table players (
    PlayerID      Serial not null primary key,
    PlayerName    text    not null,
    YearsPlaying  integer not null
    
);


create table DMs (
    PlayerID 	integer not null references players(PlayerID),
    YearsDMing 	integer not null,
	primary key (PlayerID)
);


create table public.Adventures (
	QuestName 				text not null primary key,
	DM 						integer not null references Players(PlayerID),
	InitialCallForQuest 	text not null,
	ActionToCompleteQuest   text not null,
    Heros 					text,
    Villains 				text,
	IsCompleted 			boolean not null,
	HighlightsOfQuest 		text
);

create table public.Chars (
	CharacterName 	text not null unique,
	Alignment  		text not null,
	Race 			text null,
	Languages	 	text,
	BodySize 		char null,
	Gender 			char null,
	
	primary key(CharacterName)
);



create table public.PCs (
    CharacterName	 text not null unique references Chars(CharacterName),
	CharecterClass	 text not null,
	LvL 			 integer not null,
	HitDie 			 integer not null,
	CurrentQuest 	 text null references Adventures(QuestName),
	CompletedQuests  text null,
	
	primary key (CharacterName)
);

create table public.NPCs (
    CharacterName 		text not null unique references Chars(CharacterName),
	ChallengeRating 	integer not null,
	Environment 		text not null,
	QuestDiscovered 	text null references Adventures(QuestName),
	IsMinion			boolean default false,
	
	primary key (CharacterName)
);

create table public.Played_By(
	PlayerID 		integer not null references Players(PlayerID),
	CharacterName 	text not null unique references Chars(CharacterName),
	
	primary key (PlayerID, CharacterName)
);



create table public.Encounters (
    
	BattleTitle 	  text unique not null,
	QuestName 		  text references adventures(QuestName),
	LootInGold 		  integer,
	Victor 			  text,
	
	primary key (BattleTitle,QuestName)
);

create table public.Fight_In(
	BattleTitle 	text not null unique references  Encounters (BattleTitle),
	CharacterName 	text not null unique references  Chars(CharacterName),
	IsAlly 			BOOLEAN not null,
	Amount 			integer DEFAULT 1 not null,
	
	primary key (BattleTitle, CharacterName)
);

create table public.Skills(
	CharacterName text not null unique references Chars(CharacterName),
	Skill1 text null,
	Skill2 text null,
	Skill3 text null,
	Skill4 text null,
	Skill5 text null,	
	
	primary key (CharacterName)
);

create table public.Euipped_Items (
	CharacterName text not null unique references Chars(CharacterName),
	GoldPieces 		 int,
	Armor 			 text,
	ArmorBonus 		 integer,
	Shield 			 text,
	ShieldBonus 	 integer,
	MainCombatWeapon text,
	MCWDamage 		 text,
	MCWCrit 		 text,
	MainRangedWeapon text default null,
	MRWDamage 		 text default null,
	MRWCrit 		 text default null,
	Ammunition 		 integer,
	ActiveItem 		 text default null,
	
	primary key (CharacterName)
);

create table public.Combat_Info(
	CharacterName text not null unique references Chars(CharacterName),
	
	HP 				 integer not null,
	AC 				 integer null,
	SpeedFT 		 integer not null,
	SpecialSpeedType text null,
	SpecialSpeedFT   integer null,
	StrongAgainst    text null,
	WeakAgainst 	 text null,
	
	primary key (CharacterName)
);
create table public.Spells(                              
	CharacterName text not null unique references Chars(CharacterName),
	
	MaxSpellLvL integer not null,
	FavoriteLvL1 text,
	FavoriteLVL2 text,
	FavoriteLVL3 text,
	FavoriteLVL4 text,
	FavoriteLVL5 text,
	FavoriteLVL6 text,
	FavoriteLVL7 text,
	FavoriteLVL8 text,
	FavoriteLVL9 text,

	primary key (CharacterName)
);

Insert into Players(PlayerID, PlayerName,YearsPlaying)
Values  (1,'Brian Powers',4),
		(2,'Alan Labouseur',7),
        (3,'Chris Nadramia',6),
        (4,'Jacquie Buck',1),
        (5,'Isaiah Batkay',3),
        (6,'Aidan Smith',10),
        (7,'Jake Kurkapoly',6);
		
Insert into DMs(PlayerID,YearsDMing)
values (1,2),
	   (6,8),
       (5,2);
	   
Insert into Adventures(QuestName,DM, InitialCallForQuest,ActionToCompleteQuest,
                       Heros,Villains,
                       IsCompleted,HighlightsOfQuest)
Values ('Duvars Wrath',1,'Duvar Becoming unbound by the wizard Labous The Wise' ,'Kill Duvar',
        '(Players)Volvic, Palor and Labous The Wise', 'Duvar and Giilesh'
        ,true,
        'Palor achieved the highest honor of Kings Personal Gaurd and volvic can turn into a giant tree'),
        
       ('The Dead Walking',5,'Hadeses Linking Her Life Force to the Fountian of Youth','Break the link with Hadeses and the Fountian of Youth',
        '(Players)Palor,Zuku,Volvic','Hadeses and Lady Death'
        ,true,'Zuku went Dire Tiger Form and fufilled the prophecy of the Genisis People'),
        
		('The Life of a Slave',6,'Our heroes awoke in the basement of a dusty tavern all chained to the wall. With some effort they were able to break out of the shackles and ambush their captors. 
		 and are now on the run','Slay the Masters of the Enfoon Mines'
         ,'(Players)Palor,Zuku,Volvic','Masters of the Enfoon Mines'
         ,false,'Volvic can turn into any burroing animal at will and Palor crowd surfing his army as they charged the Mines the first time'),
        
        ('The Power Of the Mind',6,'Sirous and Versila Have escaped from prison Mysterously and they are both extreamly deadly Opponents'
         ,'Discover How they broke out and bring them in to the law'
         ,'(Players)Verona,Rumba','Sirous and Versila'
         ,false,'Verona Was put incharge of the Party for the first time and Under Presure'),
        
        ( 'Warriors Paradise',5,'Our Heros were selected by the War Gods for the ultimate Fighting competition','Win The Contest'
         ,'(Players)Rumba, Verona and Grugar','Kallean and Kurshuk'
         ,true,'The Battle A-top of the clouds and Test of a true warrior'),
         
		('Life From the Other Side',1,'Our heros Became tired of honest living and turn to crime','Take King Trems Fortune and Kingdom'
         ,'King Trem and his Elites','(Players)Pressfin the Phoenix, Octavia and Labous The Wise',false,'Raiding, pilliging, stealing and killing'
		 );
         
Insert into Chars (CharacterName,Alignment,Race,Languages,BodySize,Gender)	
Values  ('Zuku','NG','Human','Common,Jungle Cat,Sylzan','M','M'),

		('Volvic','NG','Gnome','Common,Gnome,Sylzan','S','M'),	
        ('Hadeses','CE','Undead-Human','Common,Undead, Elvish','M','F'),	
        
		('Duvar','LE','Red Dragon','Common,Draconic','C','M'),		
        ('Grugar','CG','Half-Orc','Common,Orcish','L','M'),		
        
		('Palor','LG','Human','Common','M','M'),		
        ('Labous The Wise','TN','Human','ALL','M','M'),		
        
		('Sirous','TN','Gnome','Common,Gnome,Elvish,Goblinoid','S','M'),	
        ('Versila','TN','Elf','Common,Elvish,Gnome','M','F'),	
        
		('Kurshuk','LE','Human','Common','M','M'),	
        ('Kallean','LE','Half-Orc','Common, Orcish','L','M'),	
        
        ('King Trems','NG','Dwarf','Common,Jungle Cat,Sylzan','S','M'),
        ('King Trems Elites','LG','Dwarf','Common,Jungle Cat,Sylzan','M','M'),	
        
		('Pressfin the Phoenix','CE','Elf','Common,Elvish, Acient Ignis ','M','F'),	
        ('Rumba','CG','Half-Orc','Common,Orcish','L','M'),	
        
		('Skeleton','TN',null,'Undead',null,null),		
        ('Zombie','NE',null,'Undead',null,null),		
        
		('Kobold','TN','Kobold','Common,Goblinoid,Orcish','s',null),	
        ('Octavia','NE','Gnome','Common,Gnome,Elvish,Goblinoid','S','F'),	
        
		('Verona','NG','Elf','Common,Elvish,Gnome','M','F'),		
        ('Orc','TN','Orc','Common,Orcish','L',null);
		 
insert into PCs(CharacterName,CharecterClass,LvL,HitDie,CurrentQuest,CompletedQuests)
Values  ('Zuku','Druid',8,6,'The Life of a Slave','The Dead Walking,Duvars Wrath'),

        ('Volvic','Druid',20,6,'The Life of a Slave','The Dead Walking Duvars Wrath'),
        
		('Grugar','Warrior',5,8,null,'Warriors Paradise'),
        
        ('Palor','Palladian',20,12,'The Life of a Slave','The Dead Walking'),
        
		('Labous The Wise','Wizard',20,4,'Life From the Other Side','Duvars Wrath'),
        
		('Pressfin the Phoenix','Wizard',8,4,'Life From the Other Side',null),
        
		('Rumba','Warrior',3,8,'The Power Of the Mind','Warriors Paradise'),
        
		('Octavia','Thief',17,4,'Life From the Other Side',null),
                
		('Verona','Ranger',4,6,'The Power Of the Mind','Warriors Paradise');
		

Insert into played_by(PlayerID,CharacterName)
Values (7, 'Volvic'),
	   (2, 'Labous The Wise'),
	   (3, 'Palor'),
	   (4, 'Octavia'),
	   (4, 'Verona'),
	   (5, 'Rumba'),
	   (6, 'Zuku'),
	   (7, 'Grugar'),
	   (7, 'Pressfin the Phoenix');
		
		
insert into NPCs(CharacterName,ChallengeRating,Environment,QuestDiscovered,IsMinion)
Values  ('Hadeses',15,'The Plain of the Dead','The Dead Walking',false),
		('Duvar',30, 'The Plain of Chaos and Fire','Duvars Wrath',false),
		('Sirous', 8, 'UnderGround','The Power Of the Mind',false),
		('Versila', 6, 'Urban','The Power Of the Mind',false),
		('Kurshuk', 3, 'The Battle Ground','Warriors Paradise',false),
		('Kallean', 5, 'The Battle Ground','Warriors Paradise',false),
		('King Trems',1,'Noble Palaces','Life From the Other Side',false),
		('King Trems Elites',10,'Noble Palaces','Life From the Other Side',false),
		('Orc',2,'Tempreate Hills','Warriors Paradise',true),
		('Skeleton',1,'Tempreate Forests','The Dead Walking',true),
		('Zombie',3,'Tempreate Forests','The Dead Walking',true),
		('Kobold',1,'Tempreate Forests','The Life of a Slave',true);
		

		
Insert Into Encounters(BattleTitle,QuestName,LootInGold,Victor)
Values ('Worlds End', 'Duvars Wrath',20984658,'Players'),--Duvar vs Labous
		('Dragon Breach','Duvars Wrath',null,'Duvar'),--Duvar broke out
		
		
		('Dead Rising','The Dead Walking',2345,'Players'),--The dead rose
		('Hadeses Death','The Dead Walking',3423534,'Players'),--The dead rose
		
		
		('Breaking out','The Life of a Slave',395,'Players'),--
		('Failing to take The mines','The Life of a Slave',0,'Masters of the Enfoon Mines'),
		('Storming The mines','The Life of a Slave',62346,'Players'),
		
		
		('Attempting to collect','The Power Of the Mind',0,'Sirous and Versila'),
		('Finding truth','The Power Of the Mind' ,60,'Players'),
		
		
		('Orc Inundations','Warriors Paradise',21,'Players'),--Opening fight
		('Qualifyer','Warriors Paradise',432,'Players'),--Find Beast
		('Championship Round', 'Warriors Paradise',1232,'Players'),
		
		('Taking the Farms','Life From the Other Side',3242351,'Players'),
		('Being Hunted', 'Life From the Other Side', 0,'King Trems Elites');

Insert Into Equipped_Items(CharacterName,GoldPieces,Armor,ArmorBonus,Shield,ShieldBonus,
							MainCombatWeapon,MCWDamage,MCWCrit,MainRangedWeapon,MRWDamage,MRWCrit,Ammunition,ActiveItem)
Values	('Zuku',214245,'Leather',2,null,null,'Claws','2D6','17-20 x2',null,null,null,null,'Ring of the Lycanthropes'),	

		('Volvic',4245,'Leather',2,'Leather',2,'QuaterStaff','2D4','18-20 x2','Sling 30ft','1D4','20 x3',50,'Ring of Consititution'),
        
		('Duvar',null,'DragonSkin','10',null,null,'Claw','7D6','19-20 x5','Fire Breath 120ft Cone','8D12','20 x3',30,null),	
        
		('Grugar',43,'Chain-mail',3,null,null,'Double sided Orcish Sword','2D8','18-20 x2','Throwing Axe 30ft','1D6','20 x2',12,'Ring of Rage'),
        
		('Palor',345,'Steel',4,'Tower',4,'Holy Sun Sword','1D8','18-20 x2','Throwing Knife 30ft','1D6','20 x2',30,'Amulet Of the Sun'),		
        
		('Kallean',null, 'Oru',6,'Fore-Arms',2,'Hands','1D12','18-20 x2','Javelen','3D8','20 x2',20,null),
        
		('Sirous',345,'Leather',2,null,null,'Dagger','1D4','10-20 x4','Bombs 10ft','3D8','20 x2',10,'Amulet Of Knowledge'),
        
		('Versila',323445,'Leather',2,null,null,'Scemitar','1D6','18-20 x2',null,null,null,null,'Amulet Of Seduction'),
        
		('Kurshuk',null,'Oru',6,null,null,'Katana','1D12','18-20 x2','Javelen','3D8','20 x2',2,null),	
        
		('King Trems Elites',null,'Steel',4,'Steel',3,'Dwarvish Great Sword','2D8','18-20 x2','CrossBow 50ft','1D6','20 x2',10,null),
        
		('Rumba',43,'Chain-mail',3,null,null,'Double sided Orcish Sword','2D8','18-20 x2','Throwing Axe 30ft','1D6','20 x2',20,'Ring of Rage'),	
        
		('Kobold',12,'Leather',2,'Leather',2,'QuaterStaff','2D4','18-20 x2','Sling 30ft','1D4','20 x3',5,null),
        
		('Octavia',323445,'Leather',2,null,null,'Twin Blades','1D6','18-20 x2','Poisen Dart 20 ft','1d8','20 x2',10,null),
        
		('Verona',323445,'Leather',2,null,null,'Twin Blades','1D6','18-20 x2','Long Bow 80ft','1d8','20 x2',10,null),
        
		('Orc',10,'Leather',2,'Leather',2,'Orcish Battle Axe','2D4','18-20 x2','Sling 30ft','1D6','20 x3',5,null);
        

Insert Into Spells (MaxSpellLvL,FavoriteLvL1,FavoriteLvL2,FavoriteLvL3,FavoriteLvL4,FavoriteLvL5,FavoriteLvL6,
					FavoriteLvL7,FavoriteLvL8,FavoriteLvL9)
Values  ('Zuku',4, 'Create Water','GoodBerries','Fire Trap','Call Lightening'),

		('Volvic',9,'Flare','Guidance','Barkskin','Poison','Anmial Growth','Fire Seeds','Wind Walk','Animal Shape Change','Shape Change'),
        
		('Palor',4,'Bless','Bulls Strength','Dispell Magic','Holy Sword'),
        
		('Hadeses',9,'Disrupt Undead','Blind/Deafness','Cause Fear','Poison','Deep Slumber','Gentle Respose','Animate Dead','Astral Projection','Clone'),
        
		('Pressfin the Phoenix',5,'Flare','Fireball','Fire Trap','Call Lightening','FireStrom'),
        
		('Labous The Wise',9,'Acid Splach','Majic Hands','See Invisibility','Darkness','Scorching Ray','Mind Control','Blink Step','Summon Monster IIV','Meteor Showers');

Insert Into Abilities(CharacterName,Strength,Dexterity,Constitution,Intelligence,Wisdom,Charisma)
	values ('Zuku',15,16,14,20,12,14),
			('Volvic',12,16,24,15,12,14),
			('Hadeses',8,5,10,17,18,3),
			('Duvar',30,22,28,23,30,2),
			('Grugar',20,16,18,4,6,5),
			('Palor',18,16,22,15,12,14),
			('Labous The Wise',10,12,11,30,30,17),
			('Sirous',9,16,10,30,22,20),
			('Versila',12,16,24,15,12,14),
			('Kurshuk',12,16,24,15,12,14),
			('Kallean',25,16,24,15,12,11),
			('King Trems',1,1,5,12,17,19),
			('King Trems Elites',20,16,20,15,12,14),
			('Pressfin the Phoenix',11,14,11,19,18,14),
			('Rumba',20,16,18,9,7,4),
			('Skeleton',8,5,11,5,1,0),
			('Zombie',14,5,11,5,1,0),
			('Kobold',12,14,12,11,10,12),
			('Octavia',12,24,24,15,12,14),
			('Verona',12,16,24,15,12,14),
			('Orc',17,13,15,9,9,7);
			
Insert Into Fight_In(BattleTitle, CharacterName, IsAlly,Amount)
Values 
		('Worlds End','Duvar',False,1),
	   ('Worlds End','Labous The Wise',true,1),
	   
	   ('Dragon Breach','Duvar',False,1),
	   ('Dragon Breach','Labous The Wise',true,1),
	   ('Dragon Breach','Volvic',true,1),
	   ('Dragon Breach','Zuku',true,1),
		('Dragon Breach','Palor',true,1),
	  
	  ('Dead Rising', 'Hadeses',false,1),
	  ('Dead Rising','Zuku',True,1),
	  ('Dead Rising','Volvic',True,1),
	  
	  ('Hadeses Death', 'Hadeses',false,1),
	  ('Hadeses Death','Zuku',True,1),
	 

	 ('Breaking out','Palor',true,1),
	 ('Breaking out','Volvic',true,1),
	 ('Breaking out','Zuku',true,1),
	 
	 ('Failing to take The mines','Palor',true,1),
	 ('Failing to take The mines','Volvic',true,1),
	 ('Failing to take The mines','Zuku',true,1),
	 ('Failing to take The mines','Kobalds',false,50),
	 ('Failing to take The mines','Orcs',false,25),
	 
	 ('Storming The mines','Palor',true,1),
	 ('Storming The mines','Volvic',true,1),
	 ('Storming The mines','Zuku',true,1),
	 
	 ('Attempting to collect','Sirous',false,1),
	 ('Attempting to collect','Versila',false,1),
	 ('Attempting to collect','Verona',True,1),
	 ('Attempting to collect','Rumba',True,1),
	 
	 ('Finding truth','Sirous',true,1),
	 ('Finding truth','Rumba',true,1),
	 ('Finding truth','King Trems Elites',true,10),
	 
	 ('Orc Inundations','Rumba',true,1),--Opening fight
	 ('Orc Inundations','Grugar',true,1),
	 ('Orc Inundations','Verona',true,1),
	 ('Orc Inundations','Orcs',true,30),
	 
	 ('Qualifyer','Rumba',null,1),
	 ('Qualifyer','Grugar',null,1),
	 ('Qualifyer','Verona',null,1),
	 
	
	('Championship Round','Rumba',true,1),
	('Championship Round','Verona',true,1),
	('Championship Round','Kurshuk',False,1),
	('Championship Round','Kallean',false,1),
	
	('Taking the Farms', 'Pressfin the Phoenix',true,1),
	('Taking the Farms', 'Octavia',true,1),
	('Taking the Farms', 'Labous The Wise',true,1),
	
	('Being Hunted', 'Pressfin the Phoenix',true,1),
	('Being Hunted','Octavia',true,1),
	 ('Being Hunted', 'Labous The Wise',true,1);
     
     
insert Into Combat_Info(CharacterName,HP,SpeedFT,SpecialSpeedType,SpecialSpeedFT,StrongAgainst,WeakAgainst)
values('Zuku',36,50,null,null,'Undead',null),

	  ('Volvic',150,20,'Mounted',150,'Undead',null),
      
	   ('Hadeses',20,50,null,null,'Undead','Holy'),
       
	   ('Duvar',430,200,'Flying',400,'Fire',null),
       
	  ('Grugar',42,30,null,null,null,null),
      
	  ('Palor',420,25,null,null,'Undead',null),
      
	  ('Versila',20,40,null,null,'Men',null),
      
	  ('Labous The Wise',50,35,null,null,null,null),
      
	  ('Rumba',42,30,null,null,null,null),
      
	  ('Skeleton',7,10,null,null,null,null),
      
	  ('Zombie',12,15,null,null,null,null),
      
	  ('Kobold',4,20,null,null,null,null),
      
	  ('Skeleton',50,35,null,null,null,null),
      
	  ('Sirous',20,15,null,null,null,null),
      
	  ('Kurshuk',75,30,null,null,null,null),
      
	  ('King Trems Elites',50,20,null,null,null,null);
	  
insert into Skills(CharacterName,Skill1,Skill2,Skill3,Skill4,Skill5)
values ('Zuku','Acrobatics','Stealth','Heal','History',null),
	  ('Volvic','Nature','Stealth','Preception','History',null),
	  ('Grugar','Religion','Athletics','Endurance','Streetwise',null),
	  ('Rumba','Endurance','Athletics','Dungeoneering','Streetwise','Religion'),
	  ('Palor','Bluff','Literacy','Athletics','Streetwise','Religion'),
	  ('Labous The Wise','Literacy','linguistics','Bluff','Perception');


Create Trigger Conmod 
After insert or UPDATE
on Abilities
For Each Row
Execute Procedure Conmod();

CREATE or Replace Function Conmod() Returns Trigger as
$Conmod$

DECLARE @Con int;
DECLARE @Conmod int;

SET @Con = (SELECT Constitution 
			From inserted Abilities);
            
Begin
if @Con <=1
	Set @Conmod = -5
ELSIF 2 <= @Con <= 3
	Set @Conmod = -4
ELSIF 4 <= @Con <= 5
	Set @Conmod = -3
ELSIF 6 <= @Con <= 7 
	Set @Conmod = -2
ELSIF 8 <= @Con <= 9
	Set @Conmod = -1
ELSIF 10 <= @Con <= 11
	Set @Conmod = 0
ELSIF 12 <= @Con <= 13
	Set @Conmod = 1
ELSIF 14 <= @Con <= 15
	Set @Conmod = 2
ELSIF 16 <= @Con <= 17
	Set @Conmod = 3
ELSIF 18 <= @Con <= 19
	Set @Conmod = 4
ELSIF 20 <= @Con <= 21
	Set @Conmod = 5
ELSIF  22 <= @Con <= 23
	Set @Conmod = 6
ELSIF 24 <= @Con <= 25
	Set @Conmod = 7
ELSIF 26 <= @Con <= 27
	Set @Conmod = 8
ELSIF 28 <= @Con <= 29
	Set @Conmod = 9
ELSIF @Con >= 30
	Set @Conmod = 10
	
	insert into Abilities(Conmod)
	values (@Conmod);
    
    end;
    $Conmod$
    LANGUAGE plpgsql;
    
    
	  
Create Trigger Dexmod 
After insert
on Abilities
For Each Row
Execute Procedure Dexmod();

Create or Replace Function Dexmod() Returns Trigger as
$Dexmod$

DECLARE @Dex int;
DECLARE @Dexmod int;


            
Begin

SET @Dex = (SELECT Dexterity 
			From inserted Abilities);
            
if @Dex <=1
	Set @Dexmod = -5
ELSIF 2 <= @Dex <= 3
	Set @Dexmod = -4
ELSIF 4 <= @Dex <= 5
	Set @Dexmod = -3
ELSIF 6 <= @Dex <= 7 
	Set @Dexmod = -2
ELSIF 8 <= @Dex <= 9
	Set @Dexmod = -1
ELSIF 10 <= @Dex <= 11
	Set @Dexmod = 0
ELSIF 12 <= @Dex <= 13
	Set @Dexmod = 1
ELSIF 14 <= @Dex <= 15
	Set @Dexmod = 2
ELSIF 16 <= @Dex <= 17
	Set @Dexmod = 3
ELSIF 18 <= @Dex <= 19
	Set @Dexmod = 4
ELSIF 20 <= @Dex <= 21
	Set @Dexmod = 5
ELSIF  22 <= @Dex <= 23
	Set @Dexmod = 6
ELSIF 24 <= @Dex <= 25
	Set @Dexmod = 7
ELSIF 26 <= @Dex <= 27
	Set @Dexmod = 8
ELSIF 28 <= @Dex <= 29
	Set @Dexmod = 9
ELSIF @Dex >= 30
	Set @Dexmod = 10
	
	insert into Abilities(Dexmod)
	values (@Dexmod);
    end;
    $Dexmod$
    LANGUAGE plpgsql;

		  
Create Trigger GetAC 
After insert
on Combat_Info
For Each Row
Execute Procedure GetAC();

Create or Replace Function GetAC() 
Returns Trigger as ' GetAC

DECLARE @ArmorBonus int;
DECLARE @ShieldBonus int;
DECLARE @Dexmod int;
DECLARE @AC int;


            
Begin
    SET @Dexmod = (SELECT Dexmod,
				From Abilities);
	SET @ArmorBonus = (SELECT ArmorBonus
					From equipped_items);
	SET @ShieldBonus = (SELECT ShieldBonus
					From equipped_items);
                    
	@AC = @Dexmod + @ArmorBonus + @ShieldBonus + 10
	
	insert into combat_info(AC)
	values (@AC);
    end;
    'LANGUAGE plpgsql;
    
    
    Create Trigger GetHP 
After insert
on PC.LVL
For Each Row
Execute Procedure GetHP();

Create or Replace Function GetHP() 
Returns Trigger as ' GetHP

DECLARE @Conmod int;
DECLARE @hitdie int;
DECLARE @HP
    
    Begin
    
SET  @Conmod  = (SELECT Conmod,
				 From Abilities);

SET @hitdie = (SELECT HitDie 
               From PCs);

SET @HP = select trunc(random() *  @hitdie + 1);
	
	insert into combat_info(HP)
	values (@AC);
    end;
    'LANGUAGE plpgsql;  

							

	
		Create ROLE DM;	
		Create ROLE Player;
        
		GRANT ALL ON ALL tables in schema public to DM;
		REVOKE ALL ON ALL tables in schema public from Player;
		GRANT SELECT ON PCs to Players;
		GRANT SELECT ON Chars to Players;
		

        
        SELECT sum(Amount) Title
		From flight_in
		Where BattleTitle = (  SELECT BattleTitle 
		From Encounters
		Where QuestName = ‘The Life of a Slave’;

        
        
        
        
        