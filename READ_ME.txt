 To start the program provide/adjust the following:
%  
%  1) If you'd like to analyse surgery-sequences:
%    1.1)Prepare 2 types of .txt files: 
%            - The first type is to import the
%              Novice/Expert/Template-Data; as an example take a look at
%              'Novice1.txt'; the layout and the name(Name example: 3 Novice 
%              textfilex --> Novice1.txt; Novice2.txt; Novice3...) 
%              MUST be the same as there; Layout: As many
%              rows as surgeries performed by the participant but MAX two
%              columns for characteristic partition of each surgery;
%              Furthermore MAX 5 different templates --> one per row
%          
%            - The second type is to import the performance
%              feedback steps; as an example take a look at
%              'Crucial_Feedback_Cath_Steps1.txt'; the layout and the name MUST be the
%              same as there; MAX 10 rows as performance feedback steps defined by the
%              user and MAX TWO columns; the first column for description
%              and the second for the corresponding abbreviation. If the
%              surgery you desire to analyse has TWO CHARACHTERISTIK PARTS
%              (P1,P2) provide one 'Crucial_Feedback_Cath_Steps1.txt' and one  
%              'Crucial_Feedback_Cath_Steps2.txt' for each part. 
%              
%    1.2)Score:
%              The initial Score of every participant is set to be 10. As a
%              first step the edit-distances(only levenshtein distance) 
%              are analysed and the score is calculated: there are 
%              4 different "intervals" 
%
%                 first: edit-distance == 0 --> InitialScore - 0
%                 second: 1 <= edit-distance <= 2 --> InitialScore - 1
%                 third: 3 <= edit-distance <= 5 --> InitialScore - 3
%                 fourth: 6 <= edit-distance <= 5 --> InitialScore - 5
% 
%              Then, in a second step the user can provide a weighting of
%              his PF-steps. The minimum weighting is a deduction of -0.5
%              which one can weight up to four times to get a deduction of -2
%              for more important steps. The program can either find out if
%              a surgeon did undertake a specific step or if he did NOT and
%              adjust the score respectively to the user's input.
%              Furthermore the user can define steps for which he is
%              interested in the number of apperances.. For these
%              steps the user can define from which count of appearances on he wants the 
%              program to undertake a deduction. 
% 
%   2) If you'd like to analyse eye-tracking-sequences(AOI-sequences):
%     2.1)Prepare 2 type of .txt file:       
%              The names of the .txt files must be as following: 
%              - for Novices/Participants: Participants_Type1.txt, where
%                type stands for number of different experiments. These
%                files can contain as many rows as novices recorded during
%                the specific experiment and as many columns as parts*trials. If
%                a trial is separated in a first and second part, the user
%                can provide this information with the second question
%                asked from the program. AS AN EXAMPLE TAKE A LOOK AT THE Examples-Files
%                FOLDER. 
%              - The same as explained before must be done for the Experts:
%                Experts_Type2.txt is a example for the name of Expert-sequences from 
%                experiment type2. 
%              - For the Template file: Same layout with a single sequence 
%                per part or a whole experiment-set with all trials, 
%                which the user defines as to be the ideal-sequence. 

%              - As a last part the user needs to provide a self-defined
%                text-file where one provides crucial AOI-patterns or
%                single AOI's with the corresponding abbreviations. In the first column
%                the user can place a description of the abbreviation and in the
%                second column he can add the corresponding abbreviations. The
%                program then searches as defined by the user for
%                appearances, patterns or a combination of the two. The user can define
%                if he wants the program to give the number of total
%                appearances of the AOI-abbreviation or if it shall simply
%                check if the AOI or AOI-pattern appeared once in the
%                sequence. 

%              - Store all the .txt files in the DATA-folder in the
%                eye_track_seq-folder. 
%                
%     2.2)Change data-set: If the user wishes to analyse a different
%         experiment-data-set, he has to change the number at the end of the
%         file-names in the code. For example from Participants_Type1.txt, 
%         Experts_Type1.txt, Template_Type1.txt and Find_Type1.txt for experiment 1 
%         to Participants_Type2.txt, Experts_Type2.txt, Template_Type2.txt and 
%         Find_Type2.txt to analyse now data from experiment two. 
%