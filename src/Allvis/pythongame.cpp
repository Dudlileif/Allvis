#include <pythongame.h>
#include <QThread>

int PythonGame::run_game(){
    QProcess *process = new QProcess(); // Creates a new process
    QString  command("python");         // The command to be run by the process
    QStringList params = QStringList() << "/home/pi/game.py";   // Parameter for the command
    //QStringList params = QStringList () << "game.py";     // Different parameter for testing on a different device, game.py must be in the same folder as the executable
    process->setProcessChannelMode(QProcess::MergedChannels);   // Standard output and error data use the same output channel
    process->start(command, params);    // Starts a process with the command "python /home/pi/game.py"
    process->waitForFinished();         // Waits until the script is finished
    QString output1 = process->readAllStandardOutput(); // Variable that stores the output from the process
    // The output is unavailable if the script runs for more than 21 seconds, therefore the process is run twice with a shorter duration, standard is 10 seconds per run, see  game.py
    process->start(command, params);    // Runs the same command once more
    process->waitForFinished();         // Waits until the script is finished
    QString output2 = process->readAllStandardOutput(); // Another variable to store the output of the second run
    process->close();                   // Closes the process
    return output1.toInt()+output2.toInt(); // Adds up the integer value of the two variables and returns the sum
}
