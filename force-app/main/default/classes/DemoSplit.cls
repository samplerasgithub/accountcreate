public class DemoSplit {
    public static void splitmethod()
    {
        String splistring='4321|57778|4456';
        string[] splitted = splistring.split('\\|');
		system.debug('part1:: = ' + splitted[0]);   
		system.debug('part2:: = ' + splitted[1]);   
		system.debug('part3:: = ' + splitted[2]);                   
    }

}