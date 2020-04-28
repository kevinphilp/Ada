with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings; -- truncate right
with Ada.Strings.Maps;  use Ada.Strings.Maps;
with Ada.Characters.Handling; use Ada.Characters.Handling; -- to_lower
with Objects;
with Locations;
with Agora_Types; use Agora_Types;

procedure Agora is
   
   type All_Nouns is (North, South, East, West, Up, Down, Nothing, Note, Lantern, Rope, Torch);
   subtype Direction is All_Nouns range North .. Down;
   subtype Noun is All_Nouns range Nothing .. All_Nouns'Last;

   type Verb is (Nothing, Quit, Go, Drop, Get, Read, Look, Inspect);   
   
   type Noun_Array is array (Noun'Succ(Nothing) .. Noun'Last) of Objects.Object;   
   A_Objects : Noun_Array;
   
   type Enum_Location is (Porch, Hall, Cellar, Kitchen);
   type T_Array_Location is array (Enum_Location'Range) of Locations.Location;
   A_Locations : T_Array_Location;
   
begin
   
   for I in Noun_Array'Range loop
      A_Objects(I).Name := Name_BString.To_Bounded_String("Object name not set");
      A_Objects(I).Description := Description_BString.To_Bounded_String("Object desc not set");
      A_Objects(I).UID := 1;
      A_Objects(I).Activate := Objects.Default'Access;
   end loop;
  
   A_Objects(Note).Name := Name_BString.To_Bounded_String("Note");
   A_Objects(Note).Description := Description_BString.To_Bounded_String("A helpful note");
   A_Objects(Note).UID := 1;
   A_Objects(Note).Activate := Objects.Read'Access;
   
   A_Objects(Lantern).Name := Name_BString.To_Bounded_String("Lantern");
   A_Objects(Lantern).UID := 2;
   A_Objects(Lantern).Activate := Objects.Utilise'Access;
      
   for I in All_Nouns'Range loop
      Put_Line( Name_BString.To_String(A_Objects(I).Name) );
      A_Objects(I).Activate( A_Objects(I) );
   end loop;
   
   
   
   
   for I in A_Locations'Range loop
      A_Locations(I).Name := Name_BString.To_Bounded_String("Location name not set");
      A_Locations(I).Description := Description_BString.To_Bounded_String("Location desc not set");
      A_Locations(I).Lit := True;
      A_Locations(I).On_Enter := Locations.Default'Access;
      A_Locations(I).On_Leave := Locations.Default'Access;
   end loop;

   for I in A_Locations'Range loop
      Put_Line( Name_BString.To_String(A_Locations(I).Name) );
      A_Locations(I).On_Enter( A_Locations(I) );
   end loop;
   
   
   
   declare
      use Input_BString;
      BS : Bounded_String;
      Playing : Boolean;
      F   : Positive;
      L   : Natural;
      I   : Natural;
      Whitespace : constant Character_Set := To_Set (" .,;:!?");
      
      Found_Subject : Boolean := False;
      
      type T_Sentence is record
	 Subject : All_Nouns;
	 Object : All_Nouns;
	 Action : Verb;
      end record;
	  
      Sentence : T_Sentence;
	  
   begin
      
      Put_Line("Welcome to the Agora");
      
      Playing := True;

      while Playing loop
	 BS := To_Bounded_String(Get_Line, Right);
	 
	 Found_Subject := False;
	 Sentence.Subject := Nothing;
	 Sentence.Object := Nothing;
	 Sentence.Action := Nothing;
	 I := 1;

	 while I in To_String(BS)'Range loop
	    Find_Token
	      (Source  => BS,
	       Set     => Whitespace,
	       From    => I,
	       Test    => Outside,
	       First   => F,
	       Last    => L);			
	    
		
	    for J in All_Nouns loop
	       if To_Lower(J'Image) = To_String(BS)(F .. L) then
		  if Found_Subject = False then
		     Sentence.Subject := J;
		     Found_Subject := True;
		  else
		     Sentence.Object := J;
		  end if;
	       end if;			   
	    end loop;
	    
	    for K in Verb loop
	       if To_Lower(K'Image) = To_String(BS)(F .. L) then
		  Sentence.Action := K;
	       end if;
	    end loop;	
		
	    
	    I := L + 1;
	 end loop;  -- I in strings
		 
	 Put_Line(
		  Sentence.Subject'Image & "-" &
		    Sentence.Object'Image & "-" &
		    Sentence.Action'Image );
		 
	 exit when Sentence.Action = Quit;
      end loop; -- playing loop
		 
   end; -- Begin
         
end Agora;
