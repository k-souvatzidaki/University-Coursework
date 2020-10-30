create table departments 
(depcode int primary key, 
 depname varchar(30)
 );

create table publishers 
 ( pubid int primary key, 
   pubname VARCHAR(100)
  );
  
create table authors
(aid int primary key, 
 author varchar(50) 
 );
  
create table sterms
(tid int primary key, 
 term varchar(60)
 ); 

create table bibrecs
(bibno int primary key, 
 title varchar(200), 
 material varchar(30), 
 lang char(3),
 place varchar(40), 
 series varchar(200), 
 pubid int foreign key references publishers(pubid),  
 ); 

create table bibauthors
(bibno int foreign key  references bibrecs(bibno), 
 aid int foreign key references authors(aid), 
 primary key(bibno, aid),
 );
     
create table bibterms
(bibno int foreign key references bibrecs(bibno), 
 tid int foreign key references sterms(tid), 
 primary key (bibno, tid)
 );
  
 create table copies 
( copyno char(8) primary key, 
  bibno int foreign key references bibrecs(bibno), 
  copyloc char(3) 
); 

create table borrowers
 (bid int primary key, 
  depcode int,
  sex char(1), 
  bname varchar(60),
  );

CREATE TABLE loanstats
 (lid int primary key, 
  copyno char(8) foreign key references copies(copyno),
  bid int foreign key references borrowers(bid),
  loandate date
  );
