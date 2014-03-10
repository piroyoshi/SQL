--大量データを投入するときに単純なループを使用しない方法

Declare @p_NumberOfRows Bigint 
--作成データ数をセット
Select @p_NumberOfRows=1000000; 
With Base As
  (
    Select 1 as n
    Union All
    Select n+1 From Base Where n < Ceiling(SQRT(@p_NumberOfRows))
  ),
  Expand As
  (
    Select 1 as C From Base as B1, Base as B2
  ),
  Nums As
  (
    Select Row_Number() OVER(ORDER BY C) As n From Expand
  )

--insertするときに使用する
--インサート時にFUNCTIONを使用してデータを加工などを行うと重くなる。
Select n
from Nums  
Where n<=@p_NumberOfRows
OPTION (MaxRecursion 0); 