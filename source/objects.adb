with Ada.Text_IO; use Ada.Text_IO;
   
package body Objects is
   
   procedure Default (Self : in out Object) is
   begin
     null;    
   end Default;
   
   procedure Read (Self : in out Object) is
      use Description_BString;
   begin
     Put_Line(To_String(Self.Description ));      
   end Read;
   
   procedure Utilise (Self : in out Object) is
   begin
      case Self.State is
	 when On => Self.State := Off;
	 when Off => Self.State := On;
	 when Broken => Put_Line("Appears to be broken.");
	 when others => Put_Line("It doesn't do anything.");
      end case;	    
   end Utilise;

end Objects;
