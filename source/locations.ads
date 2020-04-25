with Agora_Types; use Agora_Types;

package Locations is
   
   type Location;  -- Partial forward declaration
   
   type Action_Ptr is access procedure(Self : in out Location);
   
   type Location is tagged	 
      record
	 Name : Name_BString.Bounded_String;
	 Description : Description_BString.Bounded_String;
	 Lit : Boolean;
	 On_Enter : Action_Ptr;
	 On_Leave : Action_Ptr;
      end record;
     
   procedure Default (Self : in out Location);  
   
end Locations;
