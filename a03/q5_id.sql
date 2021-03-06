.separator ","

create table poll (
	name varchar(100),
	telephone char(12),
	birthday char(10),
	gender char(1),
	postal char(7),
	year integer
);

.import poll_new.tmp poll

create temp table t_disease (
	not_used1 char(1),
	not_used2 char(1),
	not_used3 char(1),
	year integer,
	gender char(1),
	postal char(7),
	disease varchar(255)
);

.import Disease-Records.csv t_disease

create table disease as
	select year, gender, postal, disease from t_disease;

select name, telephone, year, gender, postal, disease
	from (
		select year, gender, postal, disease
			from disease
			group by year, gender, postal
			having count(*) = 1
	)
	inner join (
		select name, telephone, year, gender, postal
			from poll p
			group by year, gender, postal
			having count(*) = 1
	) using(year, gender, postal)
	order by 1,2,3,4,5,6
;
