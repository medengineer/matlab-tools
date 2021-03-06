%Command line version of NetworkControl

menu = [ ...
'\nAvailable commands: \n' ...  
'--------------------\n' ...
'startAcquisition\n' ...
'stopAcquisition\n' ...
'startRecording\n' ...
'stopRecording \n\n' ...
'Available queries: \n' ...
'-------------------\n' ...
'IsAcquiring\n' ... 
'IsRecording\n\n' ...
'Send a TTL event: \n' ...
'---------------------\n' ...
'TTL Channel=1 on=1\n' ...
'TTL Channel=1 on=0\n\n' ...
'To exit, enter "q", "quit", or "exit"\n\n\n' ...
];
          
networkControl = NetworkControl();
prompt = menu;

while true

    cmd = input(prompt, 's');

    if any(strcmp({'q','quit','exit','quit()'}, cmd))
        break;
    end

    try 
        nargin = length(strsplit(cmd));
        if nargin == 3 %TLL event
            ttlMessage = strsplit(cmd); 
            channel = strsplit(ttlMessage{2}, '=');
            state = strsplit(ttlMessage{3}, '=');                                                   
            cmd = ['sendTTL(', channel{2}, ',', state{2}, ')']
        end
        eval(['networkControl.' cmd]);
        prompt = '\n';
    catch ME %unrecognized command
        fprintf("Invalid command!\n\n\n");
        prompt = menu;
    end

end