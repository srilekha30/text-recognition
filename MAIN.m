%________________________________________
% PRINCIPAL PROGRAM
% Clearing the previous storage
warning off %#ok<WNOFF>
clc
close all
clear all

% Read image LOAD AN IMAGE
[filename, pathname] = uigetfile('*','Select an Image');
image=imread(fullfile(pathname, filename));
% Show image
figure();
imshow(image);
title('INPUT');
% Convert to gray scale
if size(image,3)==3 %RGB image
    image=rgb2gray(image);
end
figure();
imshow(image);
% Convert to BW
a1=0;
a2=0;
threshold = graythresh(image);
image =~im2bw(image,threshold);

for i=1:size(image,1)
    for j=1:size(image,2)
        if image(i,j)==0
            a1=a1+1;
        else
            a2=a2+1;
        end
    end
end
if a2>=a1
    image =~image;
end
figure();
imshow(image);
% Remove all object containing fewer than 20 pixels
image = bwareaopen(image,30);
%Storage matrix word from image

image=image - bwareaopen(image,4500);
word=[ ];
re=image;
%figure();
%imshow(re);
% Load templates
load templates
global templates
% Compute the number of letters in template file
numOfLetters=size(templates,2);
while 1
    %Funtion 'lines' separate lines in text
    [fl , re]=lines(re);
    re2=fl;
    figure;
    subplot(211);
    imshow(fl);
    subplot(212);
    imshow(re);
    
    %imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------
    while 1
        %Function 'chars' separate characters in text
        [fc, re2, space]=chars(re2);
        figure;
        subplot(211);
        imshow(fc);
        subplot(212);
        imshow(re2);
        % Resize letter (same size of template)
        img_r=imresize(fc,[42 24]);
        %figure();imshow(img_r);pause(2);
        %-------------------------------------------------------------------
        % Call function to convert image to text
        letter=read_letter_perso(img_r,numOfLetters);
        disp(letter);
        %disp(space); 
       if space > 20
           word=[word ' '];
       end
        % Letter concatenation
        if letter~='I'
            word=[word letter];
        end
        if isempty(re2)  %if variable 're2' in Fcn 'chars' is empty
            word=[word ' ']; %newline
            break %breaks the loop
        end
    end
    %When the sentences finish, breaks the loop
    if isempty(re)  %if variable 're' in Fcn 'lines' is empty
        break %breaks the loop
    end    
end
disp(word);
caUserInput = word;
caUserInput = char(caUserInput); % Convert from cell to string.
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
Speak(obj, caUserInput);
%i=1;
%new2word=[];
%list=[];
%word1=[];
%while(i<=length(word))
%    if(word(i)~=' ')
%        new2word=[new2word word(i)];
%    else
%        list=checkSpelling(new2word);
%        disp(new2word);
%        if(isempty(list))
%            word1=[word1 new2word ' '];            
%            caUserInput = new2word;
%            caUserInput = char(caUserInput); % Convert from cell to string.
%           NET.addAssembly('System.Speech');
%            obj = System.Speech.Synthesis.SpeechSynthesizer;
%            Speak(obj, caUserInput);
%        else
%            word1=[word1 list(1) ' '];
%            caUserInput = list(1);
%            caUserInput = char(caUserInput); % Convert from cell to string.
%            NET.addAssembly('System.Speech');
%            obj = System.Speech.Synthesis.SpeechSynthesizer;
%            Speak(obj, caUserInput);
%        end
%        new2word=[];
%    end
%    i=i+1;
%end
%word1=[word1 new2word ];

%list=checkSpelling(new2word);
%disp(new2word);
%if(isempty(list))
%     caUserInput = new2word;
%     caUserInput = char(caUserInput); % Convert from cell to string.
%     NET.addAssembly('System.Speech');
%     obj = System.Speech.Synthesis.SpeechSynthesizer;
%     Speak(obj, caUserInput);
%else
%     caUserInput = list(1);
%     caUserInput = char(caUserInput); % Convert from cell to string.
%     NET.addAssembly('System.Speech');
%     obj = System.Speech.Synthesis.SpeechSynthesizer;
%     Speak(obj, caUserInput);
%end