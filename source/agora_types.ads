with Ada.Strings.Bounded; 

package Agora_Types is
   
   package Name_BString is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 24);   
   package Description_BString is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 240);
   package Input_BString is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 240);
   
end Agora_Types;
