with Agora_Types; use Agora_Types;

package Objects is
   
   type T_State is (On, Off, Broken, Normal); 
   
   type Object;  -- Partial forward declaration
   
   type Action_Ptr is access procedure(Self : in out Object);
   
   type Object is tagged	 
	  record
		 UID : Integer;
		 Name : Name_BString.Bounded_String;
		 State : T_State;
		 Activate : Action_Ptr;
		 Description : Description_BString.Bounded_String;
	  end record;
     
   procedure Read (Self : in out Object);   
   procedure Utilise (Self : in out Object);  
   procedure Default (Self : in out Object);  
   
end Objects;
