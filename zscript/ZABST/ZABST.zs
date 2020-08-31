class ZABST
{
	ZABST_Node Root;
	
	ZABST Init() { Root = null; return self; }
	
	/*
		Just borrowed Java's hash algorithm
	*/
	static int GetNameHash(string objectName)
	{
		int objectHash = 0;
		for (int i = 0; i < objectName.Length(); i++)
			objectHash = 31 * objectHash + objectName.CharCodeAt(i);
		return objectHash;
	}
	
	void Insert(Object Data, string objectName)
	{
		if (Root == null)
			Root = new("ZABST_Node").Init(Data, objectName);
		else
			_insertBalance(_insert(Root, new("ZABST_Node").Init(Data, objectName)));
	}
	
	private ZABST_Node _insert(ZABST_Node bparent, ZABST_Node znode)
	{
		if (znode.Hash < bparent.Hash)
		{
			if (bparent.Left != null)
				return _insert(bparent.Left, znode);
			else
			{
				bparent.Left = znode;
				znode.Parent = bparent;
				bparent.setBalance();
				return bparent;
			}
		}
		else
		{
			if (bparent.Right != null)
				return _insert(bparent.Right, znode);
			else
			{
				bparent.Right = znode;
				znode.Parent = bparent;
				bparent.setBalance();
				return bparent;
			}
		}
	}
	
	private void _insertBalance(ZABST_Node parent)
	{
		if (parent.Parent != null)
		{
			if (parent.Parent.Left == parent && parent.Parent.Balance + 1 > 1)
			{
				if (parent.Balance > 0)
					_rotateLeftLeft(parent);
				else if (parent.Balance < 0)
					_rotateLeftRight(parent);
			}
			else if (parent.Parent.Right == parent && parent.Parent.Balance -1 < -1)
			{
				if (parent.Balance > 0)
					_rotateRightLeft(parent);
				else if (parent.Balance < 0)
					_rotateRightRight(parent);
			}
		}
	}
	
	private void _rotateParentSet(ZABST_Node parent, ZABST_Node beRotated)
	{
			if (parent.Parent.Left == parent)
				parent.Parent.Left = beRotated;
			else
				parent.Parent.Right = beRotated;
	}
	
	private void _rotateLeftLeft(ZABST_Node beRotated)
	{
		ZABST_Node bparent = beRotated.Parent;

		if (bparent.Parent == null)
		{
			root = beRotated;
			beRotated.Parent = null;
		}
		else
		{
			beRotated.Parent = bparent.Parent;
			_rotateParentSet(bparent, beRotated);
		}
		bparent.Parent = beRotated;
		if (beRotated.Right != null)
			bparent.Left = beRotated.Right;
		else
			bparent.Left = null;
		bparent.setBalance();
		beRotated.Right = bparent;
		beRotated.setBalance();
	}

	private void _rotateRightRight(ZABST_Node beRotated)
	{
		ZABST_Node bparent = beRotated.Parent;

		if (bparent.Parent == null)
		{
			root = beRotated;
			beRotated.Parent = null;
		}
		else
		{
			beRotated.Parent = bparent.Parent;
			_rotateParentSet(bparent, beRotated);
		}
		bparent.Parent = beRotated;
		if (beRotated.Left != null)
			bparent.Right = beRotated.Left;
		else
			bparent.Right = null;
		bparent.setBalance();
		beRotated.Left = bparent;
		beRotated.setBalance();
	}

	private void _rotateLeftRight(ZABST_Node bparent)
	{
		ZABST_Node beRotated = bparent.Right;
		beRotated.Parent = bparent.Parent;
		bparent.Parent = beRotated;
		if (beRotated.Left != null)
			bparent.Right = beRotated.Left;
		else
			bparent.Right = null;
		beRotated.Left = bparent;
		bparent.setBalance();

		_rotateLeftLeft(beRotated);
	}

	private void _rotateRightLeft(ZABST_Node bparent)
	{
		ZABST_Node beRotated = bparent.Left;
		beRotated.Parent = bparent.Parent;
		bparent.Parent = beRotated;
		if (beRotated.Right != null)
			bparent.Left = beRotated.Right;
		else
			bparent.Left = null;
		beRotated.Right = bparent;
		bparent.setBalance();

		_rotateRightRight(beRotated);
	}
	
	ZABST_Node Find(string DataName)
	{
		return _find(GetNameHash(DataName), root);
	}
	
	private ZABST_Node _find(int DataHash, ZABST_Node node)
	{
		if (node == null)
			return null;
		else if (DataHash == node.Hash)
			return node;
		else if (DataHash < node.Hash)
			return _find(DataHash, node.Left);
		else if (DataHash > node.Hash)
			return _find(DataHash, node.Right);
		else
			return null;
	}
	
	void Delete(string DataName)
	{
		_delete(GetNameHash(DataName), root);
	}
	
	private void _delete(int DataHash, ZABST_Node node)
	{
		// needs finished
	}
}

class ZABST_Node
{
	string ObjectName;
	int Hash, Balance;
	ZABST_Node Parent, Left, Right;
	
	Object Data;
	
	void setBalance()
	{
		if (Left != null)
			Balance += 1;
		if (Right != null)
			Balance -= 1;
	}
	
	ZABST_Node Init(Object Data, string ObjectName)
	{
		self.ObjectName = ObjectName;
		self.Data = Data;
		Hash = ZABST.GetNameHash(ObjectName);
		Balance = 0;
		Parent = Left = Right = null;
		return self;
	}
}