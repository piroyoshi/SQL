--��ʃf�[�^�𓊓�����Ƃ��ɒP���ȃ��[�v���g�p���Ȃ����@

Declare @p_NumberOfRows Bigint 
--�쐬�f�[�^�����Z�b�g
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

--insert����Ƃ��Ɏg�p����
--�C���T�[�g����FUNCTION���g�p���ăf�[�^�����H�Ȃǂ��s���Əd���Ȃ�B
Select n
from Nums  
Where n<=@p_NumberOfRows
OPTION (MaxRecursion 0); 