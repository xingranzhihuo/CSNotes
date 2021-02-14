/**
* 线性表的顺序结构实现
* @author 15223789730@163.com
* Date 2020.12.08
*/
//线性表的结构体：
typedef struct LNode *List;
struct LNode
{
	Elemtype Data[MAXSIZE];
	int Last;//用来记录顺序表最后一个元素的下标，即a[n-1]
}
struct LNode L;
List PtrL;
//初始化
List makeEmpty()
{
	List PtrL = (List)malloc(sizeof(struct LNode));//申请，填装结点
	PtrL->Last = -1;//设置表长为空
	return PtrL;
}
//查找
int Find(List PtrL,Elemtype X)
{
	int i = 0;
	while(i <= Ptrl->Last && PtrL->Data[i] != X)
	{
		i++;
	}
	if(i > PtrL->Last)
		return NULL;
	else
		return i;
}
//插入
void Insert(List PtrL,Elemtype X,int i)
{
	int j = 0;
	if(PtrL->Last == MAXSIZE-1)
	{
		printf("表满，无法插入！");
		return NULL;
	}
	if(i < 1 || i > PtrL->Last + 2)
	{
		printf("插入位置不合法！");
		return NULL;
	}
	for(j = PtrL->Last;j >=i-1;j--)
	{
		PtrL->Data[j+1] = PtrL->Data[j];
	}
		PtrL->Data[i-1] = X;
		PtrL->Last++;
		return;
}
//删除
void Delete(List PtrL,int i)
{
	int j = 0;
	if(i < 1 || i > PtrL->Last + 1)
	{
		printf("删除位置不合法！");
		return NULL；
	}
	for(j = i;j <= PtrL->Last;j++)
	{
		PtrL->Data[j-1] = PtrL->Data[j];
	}
	PtrL->Last--;
	return;
}
/**线性表的链式存储结构和基本操作
* @author 15223789730@163.com
* Date 2020.12.08
*/
//链式结构体
typedef struct LNode *List;
struct LNode
{
	Elemtype Data;
	List Next;
} 
List PtrL;
struct LNode;
//初始化
List InitLink()
{
	List p = NULL;//创建头指针
	List PtrL = (List)malloc(sizeof(struct LNode));//创建首元结点
	PtrL->Data = 1;
	PtrL->Next = NULL;//初始化首元结点
	p = PtrL;
	for(int i = 2; i <= 5; i++)
	{
		List x = (List)malloc(sizeof(struct LNode));//创建一个新的结点复用
		x->Data = i;
		x->next=NULL;//初始化
		PtrL->Next = x;//建立结点间逻辑关系
		PtrL = PtrL->Next;//更新结点
	}
	return p;//通过头指针访问整个链表即可
}
//求表长
int Length(List PtrL)
{
	List p = PtrL;
	int i = 0;
	while(p)
	{
		p = p->Next;
		i++;
	}
	return i;
}
//查找
1.按值查找
List Find(List PtrL,Elemtype X)
{
	List p = PtrL;
	while(p != NULL && p->Data != X)
	{
		p = p->Next;
	}
	if(p == NULL)
		return NULL;
	else
		return p;
}
2.按序号查找
List FinKth(List PtrL,int K)
{
	int i = 1;
	List p = PtrL;
	while(p !=NULL && i < K)
	{
		p = p->Next;
		i++;
	}
	if(p == NULL)
		return NULL;
	else
		return p;
}
//插入*******************************************************(有点忘了)
List Insert(List PtrL,int i,Elemtype X)
{
	List p = NULL;
	List s = NULL;
	if( i == 1)//特殊情况：所要插入的结点作为首元结点插入
	{
		s = (List)malloc(sizeof(struct LNode));
		s->Data = X;
		s->Next = PtrL;
		return s;
	}
	p = FindKth(PtrL,i-1)；
	if(p == NULL)
	{
		printf("无法插入！");
		return NULL;
	}
	else
	{
		s = (List)malloc(sizeof(struct LNode));
		s->Next = p->Next;
		s->Data = X;
		p->Next = s;
	}
	return PtrL;
}
List Delete(List PtrL,int i)
{
	List p,s;
	if( i == 1)
	{
		s = PtrL;
		if(PtrL !=NULL)
			PtrL = PtrL->Next;//从链表中删除
		else
			return NULL;
		free(s);
		return PtrL;
	}
	p = FindKth(PtrL,i-1);
	if(p == NULL)
	{
		printf("无法找到第%d个结点！",i-1);
		return NULL;
	}
	else if(p->Next == NULL)
	{
		printf("无法找到第%d个结点！",i);
		return NULL;
	}
	else
	{
		s = p->Next;
		p->Next = s->Next;
		free(s);
		return PtrL;

	}
}
/**
*线性表的顺序实现
*@author 15223789730@163.com
*@Date 2020.12.10
*/
//线性表的顺序结构
结构体定义如下：
typedef struct LNode *List;
struct LNode
{
	ElementType Data[MAXSIZE];
	int length;
}
struct LNode L;
List PtrL;
//初始化
List makeEmpty()
{
	List PtrL = (List)malloc(MAXSIZE * sizeof(struct LNode));//申请，填装结点
	PtrL->length = -1;
	return PtrL;
}
//查找
int Find(List PtrL,ElementType X)
{
	int i = 0;
	while(i < PtrL->length && PtrL->Data[i] != X)
	{
		i++;
	}	
	if(i >= PtrL->length)
		return NULL; 
	else 
		return i;
}
//插入
List Insert(List PtrL,int i,ElementType X)
{
	if(PtrL->length == MAXSIZE)
	{
		printf("表满，无法插入！");
		return NULL；
	}
	if(i < 1 || i >= PtrL->length)
	{
		printf("插入位置不合法！");
		return NULL;
	}
	while(int j = PtrL->length-1; j >=i-1；j--)
	{
		PtrL->Data[j+1] = PtrL->[j];
	}
	PtrL->Data[i-1] = X;
	PtrL->length++;
	return PtrL;
}
//删除
List Delete(List PtrL,int i)
{
	if(i < 1 || i >PtrL->length)
	{
		printf("删除位置不合法！");
		return PtrL;
	}
	while(int j = i ;j < PtrL->length;j++)
	{
		PtrL->Data[j-1] = PtrL->Data[j];
	}
	PtrL->length--;
	return PtrL;
}
