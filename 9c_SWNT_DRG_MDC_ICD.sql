SET NOCOUNT ON;

DECLARE @DataSource as nvarchar(5)
SET @DataSource = 'SWNT'  ---------------------Change


SELECT		sub3.ICD_9
			,sub3.ICD_10
into #ICD10Cosswalk
FROM		(
				SELECT		sub2.ICD_9
							,sub2.ICD_10
							,ROW_NUMBER () OVER (PARTITION BY sub2.ICD_9 ORDER BY sub2.ICD_10) as Hierarchy
				FROM		(
								SELECT		b.ICD_9
											,min(b.ICD_10) as ICD_10
								FROM		(
												SELECT		max(a.List_Period) as Latest_Year
												FROM		[BQA_Finance].[dbo].[dim_ICD_Codes] as a
											) as sub1
											INNER JOIN [BQA_Finance].[dbo].[dim_ICD_Codes] as b
												ON sub1.Latest_Year = b.List_Period
								GROUP BY	b.ICD_9
							) as sub2
				) as sub3
WHERE		sub3.Hierarchy = 1


SELECT		sub3.ICD_9
			,sub3.ICD_10
into #ICD9Cosswalk
FROM		(
				SELECT		sub2.ICD_9
							,sub2.ICD_10
							,ROW_NUMBER () OVER (PARTITION BY sub2.ICD_9 ORDER BY sub2.ICD_10) as Hierarchy
				FROM		(
								SELECT		min(b.ICD_9) as ICD_9
											,b.ICD_10
								FROM		(
												SELECT		max(a.List_Period) as Latest_Year
												FROM		[BQA_Finance].[dbo].[dim_ICD_Codes] as a
											) as sub1
											INNER JOIN [BQA_Finance].[dbo].[dim_ICD_Codes] as b
												ON sub1.Latest_Year = b.List_Period
								GROUP BY	b.ICD_10
							) as sub2
				) as sub3
WHERE		sub3.Hierarchy = 1
---------------------------------------ICD9 to ICD10 crosswalk
SELECT		sub4.Unique_Claim_Key
			,sub4.Source_ID
			,sub4.Claim_Number
			,sub4.Data_Source_Sub_Category
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_1)),'.',''),''),'') as ICD9_Diag_Code_1
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_2)),'.',''),''),'') as ICD9_Diag_Code_2
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_3)),'.',''),''),'') as ICD9_Diag_Code_3
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_4)),'.',''),''),'') as ICD9_Diag_Code_4
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_5)),'.',''),''),'') as ICD9_Diag_Code_5
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_6)),'.',''),''),'') as ICD9_Diag_Code_6
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_7)),'.',''),''),'') as ICD9_Diag_Code_7
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_8)),'.',''),''),'') as ICD9_Diag_Code_8
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_9)),'.',''),''),'') as ICD9_Diag_Code_9
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_10)),'.',''),''),'') as ICD9_Diag_Code_10
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_11)),'.',''),''),'') as ICD9_Diag_Code_11
			,isnull(nullif(replace(ltrim(rtrim(sub4.ICD9_Diag_Code_12)),'.',''),''),'') as ICD9_Diag_Code_12
			,sub4.ICD10_IND
into #Unique_Claim_ICD9
FROM		(
				SELECT		sub3.Unique_Claim_Key
							,sub3.Source_ID
							,sub3.Claim_Number
							,sub3.Data_Source_Sub_Category
							,case
									when nullif(sub3.ICD9_Diag_Code_1,'') is not null and substring(sub3.ICD9_Diag_Code_1,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_1,'.','')
									else sub3.ICD9_Diag_Code_1
								end as ICD9_Diag_Code_1
							,case
									when nullif(sub3.ICD9_Diag_Code_2,'') is not null and substring(sub3.ICD9_Diag_Code_2,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_2,'.','')
									else sub3.ICD9_Diag_Code_2
								end as ICD9_Diag_Code_2
							,case
									when nullif(sub3.ICD9_Diag_Code_3,'') is not null and substring(sub3.ICD9_Diag_Code_3,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_3,'.','')
									else sub3.ICD9_Diag_Code_3
								end as ICD9_Diag_Code_3
							,case
									when nullif(sub3.ICD9_Diag_Code_4,'') is not null and substring(sub3.ICD9_Diag_Code_4,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_4,'.','')
									else sub3.ICD9_Diag_Code_4
								end as ICD9_Diag_Code_4
							,case
									when nullif(sub3.ICD9_Diag_Code_5,'') is not null and substring(sub3.ICD9_Diag_Code_5,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_5,'.','')
									else sub3.ICD9_Diag_Code_5
								end as ICD9_Diag_Code_5
							,case
									when nullif(sub3.ICD9_Diag_Code_6,'') is not null and substring(sub3.ICD9_Diag_Code_6,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_6,'.','')
									else sub3.ICD9_Diag_Code_6
								end as ICD9_Diag_Code_6
							,case
									when nullif(sub3.ICD9_Diag_Code_7,'') is not null and substring(sub3.ICD9_Diag_Code_7,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_7,'.','')
									else sub3.ICD9_Diag_Code_7
								end as ICD9_Diag_Code_7
							,case
									when nullif(sub3.ICD9_Diag_Code_8,'') is not null and substring(sub3.ICD9_Diag_Code_8,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_8,'.','')
									else sub3.ICD9_Diag_Code_8
								end as ICD9_Diag_Code_8
							,case
									when nullif(sub3.ICD9_Diag_Code_9,'') is not null and substring(sub3.ICD9_Diag_Code_9,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_9,'.','')
									else sub3.ICD9_Diag_Code_9
								end as ICD9_Diag_Code_9
							,case
									when nullif(sub3.ICD9_Diag_Code_10,'') is not null and substring(sub3.ICD9_Diag_Code_10,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_10,'.','')
									else sub3.ICD9_Diag_Code_10
								end as ICD9_Diag_Code_10
							,case
									when nullif(sub3.ICD9_Diag_Code_11,'') is not null and substring(sub3.ICD9_Diag_Code_11,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_11,'.','')
									else sub3.ICD9_Diag_Code_11
								end as ICD9_Diag_Code_11
							,case
									when nullif(sub3.ICD9_Diag_Code_12,'') is not null and substring(sub3.ICD9_Diag_Code_12,5,1) = ''
										then replace(sub3.ICD9_Diag_Code_12,'.','')
									else sub3.ICD9_Diag_Code_12
								end as ICD9_Diag_Code_12
							,sub3.ICD10_IND
				FROM		(
								SELECT		sub2.Unique_Claim_Key
											,sub2.Source_ID
											,sub2.Claim_Number
											,sub2.Data_Source_Sub_Category
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_1,'') is null then lead(sub2.ICD9_Diag_Code_1,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_1
												end as ICD9_Diag_Code_1
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_2,'') is null then lead(sub2.ICD9_Diag_Code_2,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_2
												end as ICD9_Diag_Code_2
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_3,'') is null then lead(sub2.ICD9_Diag_Code_3,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_3
												end as ICD9_Diag_Code_3
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_4,'') is null then lead(sub2.ICD9_Diag_Code_4,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_4
												end as ICD9_Diag_Code_4
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_5,'') is null then lead(sub2.ICD9_Diag_Code_5,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_5
												end as ICD9_Diag_Code_5
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_6,'') is null then lead(sub2.ICD9_Diag_Code_6,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_6
												end as ICD9_Diag_Code_6
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_7,'') is null then lead(sub2.ICD9_Diag_Code_7,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_7
												end as ICD9_Diag_Code_7
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_8,'') is null then lead(sub2.ICD9_Diag_Code_8,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_8
												end as ICD9_Diag_Code_8
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_9,'') is null then lead(sub2.ICD9_Diag_Code_9,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_9
												end as ICD9_Diag_Code_9
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_10,'') is null then lead(sub2.ICD9_Diag_Code_10,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_10
												end as ICD9_Diag_Code_10
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_11,'') is null then lead(sub2.ICD9_Diag_Code_11,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_11
												end as ICD9_Diag_Code_11
											,case 
													when (lead(sub2.Unique_Claim_Key,1) OVER (ORDER BY sub2.Hierarchy) = sub2.Unique_Claim_Key)
														and nullif(sub2.ICD9_Diag_Code_12,'') is null then lead(sub2.ICD9_Diag_Code_12,1) OVER (ORDER BY sub2.Hierarchy)
													else sub2.ICD9_Diag_Code_12
												end as ICD9_Diag_Code_12
											,sub2.Hierarchy
											,sub2.ICD10_IND
								FROM		(
												SELECT		sub1.Unique_Claim_Key
															,sub1.Source_ID
															,sub1.Claim_Number
															,sub1.Data_Source_Sub_Category
															,sub1.ICD9_Diag_Code_1
															,sub1.ICD9_Diag_Code_2
															,sub1.ICD9_Diag_Code_3
															,sub1.ICD9_Diag_Code_4
															,sub1.ICD9_Diag_Code_5
															,sub1.ICD9_Diag_Code_6
															,sub1.ICD9_Diag_Code_7
															,sub1.ICD9_Diag_Code_8
															,sub1.ICD9_Diag_Code_9
															,sub1.ICD9_Diag_Code_10
															,sub1.ICD9_Diag_Code_11
															,sub1.ICD9_Diag_Code_12
															,sub1.ICD10_IND
															,ROW_NUMBER () OVER (PARTITION BY sub1.Unique_Claim_Key ORDER BY sub1.Allowed_Amount DESC) as Hierarchy
												FROM		(
																SELECT		
																			a.DATA_SOURCE_CD + a.PAYER_HIERARCHY_CD + a.CLAIM_ID as Unique_Claim_Key																				
																			,a.DATA_SOURCE_CD as Source_ID																			
																			,a.CLAIM_ID as Claim_Number
																			,a.PAYER_HIERARCHY_CD as Data_Source_Sub_Category																			
																			,a.ICD_DX_01_CD as ICD9_Diag_Code_1																			
																			,a.ICD_DX_02_CD as ICD9_Diag_Code_2																			
																			,a.ICD_DX_03_CD as ICD9_Diag_Code_3																			
																			,a.ICD_DX_04_CD as ICD9_Diag_Code_4																			
																			,a.ICD_DX_05_CD as ICD9_Diag_Code_5																			
																			,a.ICD_DX_06_CD as ICD9_Diag_Code_6																			
																			,a.ICD_DX_07_CD as ICD9_Diag_Code_7																			
																			,a.ICD_DX_08_CD as ICD9_Diag_Code_8																			
																			,a.ICD_DX_09_CD as ICD9_Diag_Code_9																			
																			,a.ICD_DX_10_CD as ICD9_Diag_Code_10																			
																			,a.ICD_DX_11_CD as ICD9_Diag_Code_11																			
																			,a.ICD_DX_12_CD as ICD9_Diag_Code_12																			
																			,sum(a.ALLOWED_AMT) as Allowed_Amount
																			,isnull(a.ICD10_IND,'N') as ICD10_IND
																FROM		[BQA].[dbo].[V_MEDICAL_CLAIM] as a
																WHERE		(a.PAYER_HIERARCHY_CD = @DataSource)  
																GROUP BY	
																			a.DATA_SOURCE_CD + a.PAYER_HIERARCHY_CD + a.CLAIM_ID																			
																			,a.DATA_SOURCE_CD																			
																			,a.CLAIM_ID
																			,a.PAYER_HIERARCHY_CD																		
																			,a.ICD_DX_01_CD																			
																			,a.ICD_DX_02_CD																			
																			,a.ICD_DX_03_CD 																			
																			,a.ICD_DX_04_CD																			
																			,a.ICD_DX_05_CD																			
																			,a.ICD_DX_06_CD																			
																			,a.ICD_DX_07_CD																			
																			,a.ICD_DX_08_CD																			
																			,a.ICD_DX_09_CD																			
																			,a.ICD_DX_10_CD																			
																			,a.ICD_DX_11_CD
																			,a.ICD_DX_12_CD
																			,isnull(a.ICD10_IND,'N')
															) as sub1
											) as sub2
							) as sub3
				WHERE		sub3.Hierarchy = 1
			) as sub4
-----------------------------------------------Unique claims with ICD9 codes

SELECT		
			----top 1000
			sub1.Source_ID
			,sub1.Claim_Number
			,sub1.ICD9_Diag_Code_1
			,isnull(b.ICD_10,'') as ICD_10_Diag_Code_1
			,sub1.ICD9_Diag_Code_2
			,isnull(c.ICD_10,'') as ICD_10_Diag_Code_2	
			,sub1.ICD9_Diag_Code_3
			,isnull(d.ICD_10,'') as ICD_10_Diag_Code_3
			,sub1.ICD9_Diag_Code_4
			,isnull(e.ICD_10,'') as ICD_10_Diag_Code_4
			,sub1.ICD9_Diag_Code_5
			,isnull(f.ICD_10,'') as ICD_10_Diag_Code_5
			,sub1.ICD9_Diag_Code_6
			,isnull(g.ICD_10,'') as ICD_10_Diag_Code_6
			,sub1.ICD9_Diag_Code_7
			,isnull(h.ICD_10,'') as ICD_10_Diag_Code_7
			,sub1.ICD9_Diag_Code_8
			,isnull(i.ICD_10,'') as ICD_10_Diag_Code_8
			,sub1.ICD9_Diag_Code_9
			,isnull(j.ICD_10,'') as ICD_10_Diag_Code_9
			,sub1.ICD9_Diag_Code_10
			,isnull(k.ICD_10,'') as ICD_10_Diag_Code_10
			,sub1.ICD9_Diag_Code_11
			,isnull(l.ICD_10,'') as ICD_10_Diag_Code_11
			,sub1.ICD9_Diag_Code_12
			,isnull(m.ICD_10,'') as ICD_10_Diag_Code_12
			,cast(getdate() as date) as Load_Date
			,sub1.Data_Source_Sub_Category
			,'' as MDC
			,sub1.ICD10_IND

into #TempICDData
FROM		(
				SELECT		a.Unique_Claim_Key
							,a.Source_ID
							,a.Claim_Number
							,a.Data_Source_Sub_Category
							,a.ICD9_Diag_Code_1
							,a.ICD9_Diag_Code_2
							,a.ICD9_Diag_Code_3
							,a.ICD9_Diag_Code_4
							,a.ICD9_Diag_Code_5
							,a.ICD9_Diag_Code_6
							,a.ICD9_Diag_Code_7
							,a.ICD9_Diag_Code_8
							,a.ICD9_Diag_Code_9
							,a.ICD9_Diag_Code_10
							,a.ICD9_Diag_Code_11
							,a.ICD9_Diag_Code_12
							,a.ICD10_IND
				FROM		#Unique_Claim_ICD9 as a
				WHERE		a.ICD10_IND = 'N'
			) as sub1
			LEFT OUTER JOIN #ICD10Cosswalk as b
					ON sub1.ICD9_Diag_Code_1 = b.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as c
					ON sub1.ICD9_Diag_Code_2 = c.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as d
					ON sub1.ICD9_Diag_Code_3 = d.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as e
					ON sub1.ICD9_Diag_Code_4 = e.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as f
					ON sub1.ICD9_Diag_Code_5 = f.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as g
					ON sub1.ICD9_Diag_Code_6 = g.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as h
					ON sub1.ICD9_Diag_Code_7 = h.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as i
					ON sub1.ICD9_Diag_Code_8 = i.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as j
					ON sub1.ICD9_Diag_Code_9 = j.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as k
					ON sub1.ICD9_Diag_Code_10 = k.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as l
					ON sub1.ICD9_Diag_Code_11 = l.ICD_9
				LEFT OUTER JOIN #ICD10Cosswalk as m
					ON sub1.ICD9_Diag_Code_12 = m.ICD_9

UNION ALL

SELECT		
			----top 1000
			sub1.Source_ID
			,sub1.Claim_Number
			,isnull(b.ICD_9,'') as ICD9_Diag_Code_1
			,sub1.ICD9_Diag_Code_1 as ICD_10_Diag_Code_1
			,isnull(c.ICD_9,'') as ICD9_Diag_Code_2
			,sub1.ICD9_Diag_Code_2 as ICD_10_Diag_Code_2
			,isnull(d.ICD_9,'') as ICD9_Diag_Code_3
			,sub1.ICD9_Diag_Code_3 as ICD_10_Diag_Code_3
			,isnull(e.ICD_9,'') as ICD9_Diag_Code_4
			,sub1.ICD9_Diag_Code_4 as ICD_10_Diag_Code_4
			,isnull(f.ICD_9,'') as ICD9_Diag_Code_5	
			,sub1.ICD9_Diag_Code_5 as ICD_10_Diag_Code_5
			,isnull(g.ICD_9,'') as ICD9_Diag_Code_6
			,sub1.ICD9_Diag_Code_6 as ICD_10_Diag_Code_6
			,isnull(h.ICD_9,'') as ICD9_Diag_Code_7
			,sub1.ICD9_Diag_Code_7 as ICD_10_Diag_Code_7
			,isnull(i.ICD_9,'') as ICD9_Diag_Code_8
			,sub1.ICD9_Diag_Code_8 as ICD_10_Diag_Code_8
			,isnull(j.ICD_9,'') as ICD9_Diag_Code_9
			,sub1.ICD9_Diag_Code_9 as ICD_10_Diag_Code_9
			,isnull(k.ICD_9,'') as ICD9_Diag_Code_10
			,sub1.ICD9_Diag_Code_10 as ICD_10_Diag_Code_10
			,isnull(l.ICD_9,'') as ICD9_Diag_Code_11
			,sub1.ICD9_Diag_Code_11 as ICD_10_Diag_Code_11
			,isnull(m.ICD_9,'') as ICD9_Diag_Code_12
			,sub1.ICD9_Diag_Code_12 as ICD_10_Diag_Code_12
			,cast(getdate() as date) as Load_Date
			------,sub1.Data_Source_Sub_Category
			,CASE
					WHEN sub1.Source_ID = 'AEMA' THEN 'AEMA'
					ELSE sub1.Data_Source_Sub_Category
				END AS Data_Source_Sub_Category
			,'' as MDC
			,sub1.ICD10_IND
FROM		(
				SELECT		a.Unique_Claim_Key
							,a.Source_ID
							,a.Claim_Number
							,a.Data_Source_Sub_Category
							,a.ICD9_Diag_Code_1
							,a.ICD9_Diag_Code_2
							,a.ICD9_Diag_Code_3
							,a.ICD9_Diag_Code_4
							,a.ICD9_Diag_Code_5
							,a.ICD9_Diag_Code_6
							,a.ICD9_Diag_Code_7
							,a.ICD9_Diag_Code_8
							,a.ICD9_Diag_Code_9
							,a.ICD9_Diag_Code_10
							,a.ICD9_Diag_Code_11
							,a.ICD9_Diag_Code_12
							,a.ICD10_IND
				FROM		#Unique_Claim_ICD9 as a
				WHERE		a.ICD10_IND = 'Y'
			) as sub1
			LEFT OUTER JOIN #ICD9Cosswalk as b
					ON sub1.ICD9_Diag_Code_1 = b.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as c
					ON sub1.ICD9_Diag_Code_2 = c.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as d
					ON sub1.ICD9_Diag_Code_3 = d.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as e
					ON sub1.ICD9_Diag_Code_4 = e.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as f
					ON sub1.ICD9_Diag_Code_5 = f.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as g
					ON sub1.ICD9_Diag_Code_6 = g.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as h
					ON sub1.ICD9_Diag_Code_7 = h.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as i
					ON sub1.ICD9_Diag_Code_8 = i.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as j
					ON sub1.ICD9_Diag_Code_9 = j.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as k
					ON sub1.ICD9_Diag_Code_10 = k.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as l
					ON sub1.ICD9_Diag_Code_11 = l.ICD_10
				LEFT OUTER JOIN #ICD9Cosswalk as m
					ON sub1.ICD9_Diag_Code_12 = m.ICD_10
-----------------------------------------------------------
----------------------Start add MDC
SELECT		sub3.Source_ID
			,sub3.Data_Source_Sub_Category
			,sub3.Claim_Number
			,sub3.Min_Claim_SERVICE_START_DT ------------------added 11-21-2016
			,sub3.ICD_10_Diag_Code_1
			,sub3.ICD_10_Diag_Code_2
			,sub3.ICD_10_Diag_Code_3
			,sub3.ICD_10_Diag_Code_4
			,sub3.ICD_10_Diag_Code_5
			,sub3.ICD_10_Diag_Code_6
			,sub3.ICD_10_Diag_Code_7
			,sub3.ICD_10_Diag_Code_8
			,sub3.ICD_10_Diag_Code_9
			,sub3.ICD_10_Diag_Code_10
			,sub3.ICD_10_Diag_Code_11
			,sub3.ICD_10_Diag_Code_12
			,sub3.DRG_Code
			,isnull(sub4.MDC,'NA') as MDC
into #SWNT_MDC_Dx_DRG  ----------------------------------------------------------------------change
FROM		(
				SELECT		sub1.Source_ID
							,sub1.Data_Source_Sub_Category
							,sub1.Claim_Number
							,sub2.Min_Claim_SERVICE_START_DT ------------------added 11-21-2016
							,sub1.ICD_10_Diag_Code_1
							,sub1.ICD_10_Diag_Code_2
							,sub1.ICD_10_Diag_Code_3
							,sub1.ICD_10_Diag_Code_4
							,sub1.ICD_10_Diag_Code_5
							,sub1.ICD_10_Diag_Code_6
							,sub1.ICD_10_Diag_Code_7
							,sub1.ICD_10_Diag_Code_8
							,sub1.ICD_10_Diag_Code_9
							,sub1.ICD_10_Diag_Code_10
							,sub1.ICD_10_Diag_Code_11
							,sub1.ICD_10_Diag_Code_12	
							,sub2.DRG_Code
				FROM		(
								SELECT		a.Source_ID
											,a.Data_Source_Sub_Category
											,a.Claim_Number
											,a.ICD_10_Diag_Code_1
											,a.ICD_10_Diag_Code_2
											,a.ICD_10_Diag_Code_3
											,a.ICD_10_Diag_Code_4
											,a.ICD_10_Diag_Code_5
											,a.ICD_10_Diag_Code_6
											,a.ICD_10_Diag_Code_7
											,a.ICD_10_Diag_Code_8
											,a.ICD_10_Diag_Code_9
											,a.ICD_10_Diag_Code_10
											,a.ICD_10_Diag_Code_11
											,a.ICD_10_Diag_Code_12		
								FROM		#TempICDData as a
							) as sub1
							INNER JOIN (
												SELECT		a.DATA_SOURCE_CD as Source_ID
															,a.PAYER_HIERARCHY_CD as Data_Source_Sub_Category
															,a.CLAIM_ID as Claim_Number
															,a.Primary_DRG as DRG_Code
															,a.Min_Claim_SERVICE_START_DT ------------added 11-21-2016			
												FROM		[BQA_Finance].[dbo].[SWNT_Medical_Claims_Test] as a  ---------------------Change
												WHERE		(nullif(a.Primary_DRG,'')) IS NOT NULL
												GROUP BY	a.DATA_SOURCE_CD
															,a.PAYER_HIERARCHY_CD
															,a.CLAIM_ID
															,a.Primary_DRG
															,a.Min_Claim_SERVICE_START_DT ------------added 11-21-2016
											) as sub2
								ON sub1.Source_ID = sub2.Source_ID
									AND sub1.Data_Source_Sub_Category = sub2.Data_Source_Sub_Category
									AND sub1.Claim_Number = sub2.Claim_Number
				WHERE		sub2.DRG_Code IS NOT NULL
			) as sub3
			LEFT OUTER JOIN (
								SELECT		a.ICD10
											,a.DRG
											,a.MDC
								FROM		[BQA_Finance].[dbo].[z_ICDDRG] as a

							) as sub4
				ON sub3.ICD_10_Diag_Code_1 = sub4.ICD10
					AND sub3.DRG_Code = sub4.DRG

UNION ALL

SELECT		sub3.Source_ID
			,sub3.Data_Source_Sub_Category
			,sub3.Claim_Number
			,sub3.Min_Claim_SERVICE_START_DT ------------------added 11-21-2016
			,sub3.ICD_10_Diag_Code_1
			,sub3.ICD_10_Diag_Code_2
			,sub3.ICD_10_Diag_Code_3
			,sub3.ICD_10_Diag_Code_4
			,sub3.ICD_10_Diag_Code_5
			,sub3.ICD_10_Diag_Code_6
			,sub3.ICD_10_Diag_Code_7
			,sub3.ICD_10_Diag_Code_8
			,sub3.ICD_10_Diag_Code_9
			,sub3.ICD_10_Diag_Code_10
			,sub3.ICD_10_Diag_Code_11
			,sub3.ICD_10_Diag_Code_12
			,sub3.DRG_Code
			,isnull(sub4.MDC,'NA') as MDC
FROM		(
				SELECT		sub1.Source_ID
							,sub1.Data_Source_Sub_Category
							,sub1.Claim_Number
							,sub2.Min_Claim_SERVICE_START_DT ------------------added 11-21-2016
							,sub1.ICD_10_Diag_Code_1
							,sub1.ICD_10_Diag_Code_2
							,sub1.ICD_10_Diag_Code_3
							,sub1.ICD_10_Diag_Code_4
							,sub1.ICD_10_Diag_Code_5
							,sub1.ICD_10_Diag_Code_6
							,sub1.ICD_10_Diag_Code_7
							,sub1.ICD_10_Diag_Code_8
							,sub1.ICD_10_Diag_Code_9
							,sub1.ICD_10_Diag_Code_10
							,sub1.ICD_10_Diag_Code_11
							,sub1.ICD_10_Diag_Code_12
							,sub2.DRG_Code
				FROM		(
								SELECT		a.Source_ID
											,a.Data_Source_Sub_Category
											,a.Claim_Number
											,a.ICD_10_Diag_Code_1
											,a.ICD_10_Diag_Code_2
											,a.ICD_10_Diag_Code_3
											,a.ICD_10_Diag_Code_4
											,a.ICD_10_Diag_Code_5
											,a.ICD_10_Diag_Code_6
											,a.ICD_10_Diag_Code_7
											,a.ICD_10_Diag_Code_8
											,a.ICD_10_Diag_Code_9
											,a.ICD_10_Diag_Code_10
											,a.ICD_10_Diag_Code_11
											,a.ICD_10_Diag_Code_12			
								FROM		#TempICDData as a
							) as sub1
							INNER JOIN (
												SELECT		a.DATA_SOURCE_CD as Source_ID
															,a.PAYER_HIERARCHY_CD as Data_Source_Sub_Category
															,a.CLAIM_ID as Claim_Number
															,a.Primary_DRG as DRG_Code
															,a.Min_Claim_SERVICE_START_DT ------------added 11-21-2016			
												FROM		[BQA_Finance].[dbo].[SWNT_Medical_Claims_Test] as a  ---------------------Change
												WHERE		(nullif(a.Primary_DRG,'')) IS NULL
												GROUP BY	a.DATA_SOURCE_CD
															,a.PAYER_HIERARCHY_CD
															,a.CLAIM_ID
															,a.Primary_DRG
															,a.Min_Claim_SERVICE_START_DT ------------added 11-21-2016
											) as sub2
								ON sub1.Source_ID = sub2.Source_ID
									AND sub1.Data_Source_Sub_Category = sub2.Data_Source_Sub_Category
									AND sub1.Claim_Number = sub2.Claim_Number
				WHERE		sub2.DRG_Code IS NULL
			) as sub3
			LEFT OUTER JOIN (
								SELECT		sub1a.ICD10
											,sub1a.MDC
								FROM		(
												SELECT		a.ICD10											
															,a.MDC											
															,ROW_NUMBER () OVER (PARTITION BY a.ICD10 ORDER BY a.DRG) as Hierarchy											
												FROM		[BQA_Finance].[dbo].[z_ICDDRG] as a
												GROUP BY	a.ICD10											
															,a.MDC
															,a.DRG
											) as sub1a
								WHERE		sub1a.Hierarchy = 1		
							) as sub4
				ON sub3.ICD_10_Diag_Code_1 = sub4.ICD10



SELECT		a.Description_1 as Category_1
			,a.Description_2 as Category_2
			,a.Description_3 as Category_3
			,a.Description_4 as Category_4
			,a.Description_5 as Category_5
			,replace(a.DX_5,'.','') as DX_5
			,replace(a.DX_4,'.','') as DX_4
			,a.DX_3
			,a.DX_2
			,a.DX_1
into #DX_Groupings
FROM		[BQA_Finance].[dbo].[dim_Dx_Groupings] as a


SELECT		sub2.Source_ID
			,sub2.Data_Source_Sub_Category
			,sub2.Claim_Number
			,sub2.Min_Claim_SERVICE_START_DT ----------------------added 11-21-2016
			,sub2.ICD_10_Diag_Code_1
			,sub2.ICD_10_Diag_Code_3
			,sub2.ICD_10_Diag_Code_4
			,sub2.ICD_10_Diag_Code_5
			,sub2.ICD_10_Diag_Code_6
			,sub2.ICD_10_Diag_Code_7
			,sub2.ICD_10_Diag_Code_8
			,sub2.ICD_10_Diag_Code_9
			,sub2.ICD_10_Diag_Code_10
			,sub2.ICD_10_Diag_Code_11
			,sub2.ICD_10_Diag_Code_12			
			,sub2.Category_3
			,sub2.Category_1
			,sub2.Category_2
			,sub2.DRG_Code
			,sub2.MDC
			,sub2.Hierarchy
into #DX_Matching
FROM		(
				SELECT		a.Source_ID
							,a.Data_Source_Sub_Category
							,a.Claim_Number
							,a.Min_Claim_SERVICE_START_DT ----------------------added 11-21-2016
							,a.ICD_10_Diag_Code_1
							,a.ICD_10_Diag_Code_2
							  ,a.ICD_10_Diag_Code_3
							  ,a.ICD_10_Diag_Code_4
							  ,a.ICD_10_Diag_Code_5
							  ,a.ICD_10_Diag_Code_6
							  ,a.ICD_10_Diag_Code_7
							  ,a.ICD_10_Diag_Code_8
							  ,a.ICD_10_Diag_Code_9
							  ,a.ICD_10_Diag_Code_10
							  ,a.ICD_10_Diag_Code_11
							  ,a.ICD_10_Diag_Code_12
							,sub1.Category_3
							,sub1.Category_1
							,sub1.Category_2
							,a.DRG_Code
							,a.MDC
							,ROW_NUMBER () OVER (Partition BY a.Claim_Number ORDER BY a.Claim_Number) Hierarchy
				FROM		#SWNT_MDC_Dx_DRG as a
								LEFT OUTER JOIN (
													SELECT		a.Category_3
																,a.DX_3
																,a.Category_2
																,a.DX_2
																,a.Category_1
																,a.DX_1
													FROM		#DX_Groupings as a
													GROUP BY	a.Category_3
																,a.DX_3
																,a.Category_2
																,a.DX_2
																,a.Category_1
																,a.DX_1
												) as sub1
									ON substring(a.ICD_10_Diag_Code_1,1,3) = sub1.DX_3
										AND substring(a.ICD_10_Diag_Code_1,1,1) = sub1.DX_1
			) as sub2			
WHERE		sub2.Hierarchy = 1

TRUNCATE TABLE [BQA_Finance].[dbo].[SWNT_MDC_Dx_DRG]
INSERT INTO [BQA_Finance].[dbo].[SWNT_MDC_Dx_DRG]

SELECT		sub2.Source_ID
			,sub2.Data_Source_Sub_Category		
			,sub2.Claim_Number
			,sub2.ICD_10_Diag_Code_1
			,sub2.ICD_10_Diag_Code_3
			,sub2.ICD_10_Diag_Code_4
			,sub2.ICD_10_Diag_Code_5
			,sub2.ICD_10_Diag_Code_6
			,sub2.ICD_10_Diag_Code_7
			,sub2.ICD_10_Diag_Code_8
			,sub2.ICD_10_Diag_Code_9
			,sub2.ICD_10_Diag_Code_10
			,sub2.ICD_10_Diag_Code_11
			,sub2.ICD_10_Diag_Code_12	
			,sub2.Category_1
			,sub2.Category_2
			,sub2.Category_3
			,sub2.DRG_Code
			
			,sub6.MS_DRG_Grouping as DRG_Grouping  ------------------added 11-21-2016
			,sub6.Geometric_Mean_LOS as DRG_Geometric_Mean_LOS  ------------------added 11-21-2016
			,sub6.Arithmetic_Mean_LOS as DRG_Arithmetic_Mean_LOS  ------------------added 11-21-2016
			,isnull(sub6.MDC,sub2.MDC) as MDC  ------------------added 11-21-2016
			,isnull(sub6.MDC_Description,sub2.MDC_Description) as MDC_Description  ------------------added 11-21-2016
			,sub6.Weight as DRG_Weight ------------------added 11-21-2016
			,sub6.Post_Acute as DRG_Post_Acute------------------added 11-21-2016
			,sub6.Acute_Category as DRG_Acute_Category ------------------added 11-21-2016
------into SWNT_MDC_Dx_DRG
FROM		(
				SELECT		sub1.Source_ID
							,sub1.Data_Source_Sub_Category
							,sub1.Claim_Number
							,sub1.Min_Claim_SERVICE_START_DT ----------------------added 11-21-2016
							,sub1.ICD_10_Diag_Code_1
							,sub1.ICD_10_Diag_Code_3
							,sub1.ICD_10_Diag_Code_4
							,sub1.ICD_10_Diag_Code_5
							,sub1.ICD_10_Diag_Code_6
							,sub1.ICD_10_Diag_Code_7
							,sub1.ICD_10_Diag_Code_8
							,sub1.ICD_10_Diag_Code_9
							,sub1.ICD_10_Diag_Code_10
							,sub1.ICD_10_Diag_Code_11
							,sub1.ICD_10_Diag_Code_12	
							,sub1.Category_1
							,sub1.Category_2
							,sub1.Category_3
							,sub1.DRG_Code
							,sub1.MDC
							,sub1.MDC_Description
				FROM		(
								SELECT		a.Source_ID
											,a.Data_Source_Sub_Category
											,a.Claim_Number
											,a.Min_Claim_SERVICE_START_DT ----------------------added 11-21-2016
											,a.ICD_10_Diag_Code_1
											,a.ICD_10_Diag_Code_3
											  ,a.ICD_10_Diag_Code_4
											  ,a.ICD_10_Diag_Code_5
											  ,a.ICD_10_Diag_Code_6
											  ,a.ICD_10_Diag_Code_7
											  ,a.ICD_10_Diag_Code_8
											  ,a.ICD_10_Diag_Code_9
											  ,a.ICD_10_Diag_Code_10
											  ,a.ICD_10_Diag_Code_11
											  ,a.ICD_10_Diag_Code_12
											,a.Category_1
											,a.Category_2
											,a.Category_3
											,isnull(a.DRG_Code,'NA') as DRG_Code
											,a.MDC
											,isnull(sub1a.MDC_Description,'NA') as MDC_Description
											,ROW_NUMBER () OVER (PARTITION BY a.Claim_Number ORDER BY a.Claim_Number) as Hierarchy
								FROM		#DX_Matching as a
												LEFT OUTER JOIN (
																	SELECT  a.MDC
																	   ,a.MDC_Description
																	FROM  [BQA_Finance].[dbo].[dim_DRG] as a
																	WHERE  a.MDC_Description IS NOT NULL 
																	 AND (a.MDC_Description <> 'Extensive Prcds Unrelated to Principal Diagnosis' OR a.MDC <> '00')
																	 AND (a.MDC_Description <> 'NA' OR a.MDC <> 'NA') 
																	GROUP BY a.MDC
																	   ,a.MDC_Description
																) as sub1a
						ON a.MDC = sub1a.MDC
							) as sub1
				WHERE		sub1.Hierarchy = 1
			) as sub2
			LEFT OUTER JOIN (
								------SELECT		a.MS_DRG
								------			,a.MS_DRG_Grouping      
								------FROM		[BQA_Finance].[dbo].[dim_DRG] as a
								------GROUP BY	a.MS_DRG
								------			,a.MS_DRG_Grouping
							
							SELECT		sub3.MS_DRG -------------------all added 11-21-2016
										,sub3.Geometric_Mean_LOS
										,sub3.Arithmetic_Mean_LOS
										,sub3.DRG_SVC_TYPE_CD
										,sub3.MAJOR_DIAG_CAT_CD 
										,sub3.Weight
										,sub3.Post_Acute
										------,sub3.FY_START_DT
										,IIF(sub3.FY_START_DT = sub4.min_FY_START_DT,cast('1-1-2000' as date),sub3.FY_START_DT) as FY_START_DT
										------,sub4.min_FY_START_DT
										------,sub3.FY_END_DT
										,IIF(sub3.FY_END_DT = sub5.max_FY_END_DT,cast('12-31-9999' as date),sub3.FY_END_DT) as FY_END_DT
										--------,sub5.max_FY_END_DT
										,sub3.DRG_DESC
										,sub3.MS_DRG_Grouping
										,sub3.MDC
										,sub3.MDC_Description
										,sub3.Acute_Category
							FROM		(
											SELECT		sub1.MS_DRG
														,sub1.GMLOS_QTY_NBR as Geometric_Mean_LOS
														,sub1.ALOS_QTY_NBR as Arithmetic_Mean_LOS
														,sub1.DRG_SVC_TYPE_CD
														,sub1.MAJOR_DIAG_CAT_CD
														,sub1.PMT_WGHT_NBR as Weight
														,sub1.POST_ACUTE_DRG_IND as Post_Acute
														,sub1.FY_START_DT
														,sub1.FY_END_DT
														,sub1.DRG_DESC
														,isnull(sub2.MDC,'NA') as MDC
														,isnull(sub2.MS_DRG_Grouping,'NA') as MS_DRG_Grouping
														,isnull(sub2.MDC_Description,'NA') as MDC_Description
														,isnull(sub2.Acute_Category,'NA') as Acute_Category
														,ROW_NUMBER () OVER (PARTITION BY sub1.MS_DRG,sub1.FY_START_DT ORDER BY sub1.FY_START_DT DESC) as Hierarchy
											FROM		(
															SELECT		a.DRG_CD as MS_DRG
																		,a.GMLOS_QTY_NBR
																		,a.ALOS_QTY_NBR
																		,a.DRG_SVC_TYPE_CD
																		,a.MAJOR_DIAG_CAT_CD
																		,a.PMT_WGHT_NBR
																		,CASE
																				WHEN a.POST_ACUTE_DRG_IND = 'Y' THEN 'Yes'
																				WHEN a.POST_ACUTE_DRG_IND = 'N' THEN 'No'
																				ELSE 'NA'
																			END as POST_ACUTE_DRG_IND
																		,a.FY_START_DT
																		,a.FY_END_DT
																		,a.DRG_DESC
															FROM		[BQA].[dbo].[T_DIM_DRG] as a
														) as sub1
														LEFT OUTER JOIN (
																			SELECT		a.MS_DRG
																						,a.MDC
																						,a.MS_DRG_Title
																						,a.MS_DRG_Grouping
																						,a.MDC_Description
																						,a.Acute_Category
																						,a.Post_Acute
																			FROM		[BQA_Finance].[dbo].[dim_DRG] as a
																		) as sub2
															ON sub1.MS_DRG = sub2.MS_DRG
										) as sub3
										LEFT OUTER JOIN (
														SELECT		a.DRG_CD as MS_DRG
																	,min(a.FY_START_DT) as min_FY_START_DT
																	----,max(a.FY_END_DT) as max_FY_END_DT
														FROM		[BQA].[dbo].[T_DIM_DRG] as a
														GROUP BY	a.DRG_CD
													) as sub4
											ON sub3.MS_DRG = sub4.MS_DRG
												AND sub3.FY_START_DT = sub4.min_FY_START_DT
										LEFT OUTER JOIN (
														SELECT		a.DRG_CD as MS_DRG
																	----,min(a.FY_START_DT) as min_FY_START_DT
																	,max(a.FY_END_DT) as max_FY_END_DT
														FROM		[BQA].[dbo].[T_DIM_DRG] as a
														GROUP BY	a.DRG_CD
													) as sub5
											ON sub3.MS_DRG = sub5.MS_DRG
												AND sub3.FY_END_DT = sub5.max_FY_END_DT
							WHERE		sub3.Hierarchy = 1							
							) as sub6
				ON sub2.DRG_Code = sub6.MS_DRG
					AND sub2.Min_Claim_SERVICE_START_DT BETWEEN sub6.FY_START_DT AND sub6.FY_END_DT ----------------------added 11-21-2016

DROP TABLE	#ICD10Cosswalk
			,#ICD9Cosswalk
			,#Unique_Claim_ICD9
			,#TempICDData
			,#SWNT_MDC_Dx_DRG
			,#DX_Groupings
			,#DX_Matching