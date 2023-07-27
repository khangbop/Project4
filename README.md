# Project4

World University Rankings Analysis

Giới thiệu.

Đọc dữ liệu. (Python)

Làm sạch/Xử lý dữ liệu. (Python)

Phân tích (SQL/Power BI):

Nhìn chung 3 dataset này đều thống kê xếp hạng của tất cả các trường trên thế giới.
Điểm khác biệt giữa 3 data set là do các quốc giá khác nhau thống kê
 
	- cwurData.csv (Central for World Universitiy Rankings) do nước Saudi Arabia thực hiện được thành lập từ 2012. (http://cwur.org/) 
	- timesData.csv (Times Higher Education World University Ranking) do Vương quốc Anh thành lập năm 2010. (https://www.timeshighereducation.com/world-university-rankings)
	- shanghaiData.csv (Academic Ranking of World Universities) do Trung Quốc sáng lập năm 2003. (http://www.shanghairanking.com/)
    
Câu hỏi đặt ra:

  - Nếu phải so sánh thì 3 bảng này khác và giống nhau như thế nào?
  - Những lời chỉ trích khác nhau đánh vào các bảng xếp hạng này có công bằng hay không?
  - Làm thế nào để trường cũ của bạn chống lại thế giới?
  (https://www.kaggle.com/datasets/mylesoneill/world-university-rankings?datasetId=27&sortBy=voteCount).

Đối với dataset đầu của Ả rập Saudi (CWUR): cwurData.csv
Đầu tiên ta sẽ xem Top 5 trường Đại Học tốt nhất thế giới từ 2012-2015
Tiếp theo đi sâu hơn vào từng năm.
Ta cũng sẽ tìm hiểu dựa số lượng trường Đại học theo quốc gia. Chúng ta cũng sẽ xem xét chất lượng giáo dục, việc làm của cựu sinh viên và chất lượng của các cấp bậc giảng       viên.
Kết luận.
    
Đối với dataset của Trung Quốc (ARWU): shanghaiData.csv
Dataset này bao gồm (2002-2015):
- Tổng điểm.
- Cựu sinh viên của trường đạt giải Nobel và huy chương Fields (alumni).
- Nhân viên trường đạt giải Nobel và huy chương Fields (awards).
- Các nhà nghiên cứu được trích dẫn cao (hici).
- Số lượng bài báo về khoa học tự nhiên (ns).
- Số lượng bài báo được lập chỉ mục trong Trích dẫn Khoa học Xã hội-Mở rộng và Chỉ mục Trích dẫn Khoa học (pub).
- Kết quả học tập bình quân đầu người của một tổ chức (pcp).
Bắt đầu ta cũng tìm top 10 trường Đại học tốt nhất thế giới so sánh vs nhau dựa trên cái chỉ số trên.
Tiếp theo so sánh xếp hạng dựa theo quốc gia.
Kết luận.

Đối với dataset của Vương Quốc Anh (THE): timesData.csv
Các chỉ số của Dataset:
- Teaching (teaching/the learning environment)
- International Outlook (international/staff, students and research)
- Research (research/volume, income and reputation)
- Citations (citations/research influence)
- Industry Income (income/knowledge transfer, value not available for all)
- Overall (total_score).

Dựa theo cách xếp hạng của website (https://www.timeshighereducation.com/news/ranking-methodology-2016) 
Teaching: 30%
International Outlook 7.5%
Research: 30%
Citations: 30%
Industry Income: 2.5%

Trước hết ta cũng tìm top các trường Đại học hay nhất theo từng năm.
Top xếp hạng theo quốc gia.
Ngoài những chỉ số trên thì bảng xếp hạng này còn bao gồm những chỉ số thêm (Số lượng sv, tỉ lệ % giữa sv và nv, tỉ lệ % giữa nam nữ, % số lượng du học sinh) - > dùng những chỉ số này để đối chiếu với top trường Đại học xem có ảnh hưởng ko.
Phần này mình tính để dành để so sánh các trường Đại học Việt Nam so với các trường Đại học trên thế giới (Lấy dữ liệu từ 3 bảng trên so sánh).
Nhưng RIP nước mình tận năm 2019-2020 mới lên bảng, mà lên tận top 1000 - 2000 cơ.

Mục này mình dành cho 2 dataset cuối:
Educational_attainment_supplementary_data.csv. (Trình độ học vấn)
Dataset 1st lấy từ Viện Thống kê UNESCO và Bộ dữ liệu của Barro-Lee .Trình độ giáo dục quốc gia liên quan như thế nào đến chất lượng của các trường đại học của mỗi quốc gia?
Education_expenditure_supplementary_data.csv. (Chi phí giáo dục)
Dataset 2nd lấy từ Trung tâm Thống kê Giáo dục Quốc gia (NCES) Nó thể hiện chi tiêu theo tỷ lệ phần trăm của tổng sản phẩm quốc nội. Có phải chi tiêu nhiều hơn cho giáo dục dẫn đến xếp hạng đại học quốc tế tốt hơn?
Thêm Dataset GPD đầu người theo quốc gia (https://www.kaggle.com/datasets/sudalairajkumar/undata-country-profiles?select=country_profile_variables.csv) 
Kết luận.
Tổng kết rút ra được những gì.
Chú thích.

THE END
2 cái dataset dự phòng nếu cái này easy quá: 1 cái Healthcare (Easy)
(https://www.kaggle.com/datasets/nehaprabhavalkar/av-healthcare-analytics-ii)  
vs 1 cái chỉ số Ngân hàng thế giới của 5 nước (Hard) (https://www.kaggle.com/datasets/docstein/brics-world-bank-indicators?select=BRICS+Development+Indicators) .



