import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20; 
public final static int NUM_COLS = 20; 
public final static int NUM_MINES = 50; //might want to change the number of mines later - could make it random 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined


public void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < buttons.length; r++) {
    for (int c = 0; c < buttons[r].length; c++) {

      buttons[r][c] = new MSButton(r, c);
    }
  }


  setMines();
}
public void setMines()
{

  mines = new ArrayList <MSButton>();

  //your code
  while (mines.size() < NUM_MINES) {
    int randomRow = (int)(Math.random() * NUM_ROWS);
    int randomCol = (int)(Math.random() * NUM_COLS);

    if (mines.contains(buttons[randomRow][randomCol]) == false) {

      mines.add(buttons[randomRow][randomCol]);
     // System.out.println(randomRow + " " + randomCol);
    }
  } //end of while
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{

  //  int numClicked = 0;
  //  for (int r = 0; r < NUM_ROWS; r++) {
  //    for (int c = 0; c < NUM_COLS; c++) {

  //      if (buttons[r][c].flagged == true || buttons[r][c].isClicked()) {

  //        numClicked++;
  //      }// end of first if
  //    }
  //  }

  //  for (int i = 0; i < NUM_ROWS * NUM_COLS; i ++) {


  //    if (numClicked == NUM_ROWS * NUM_COLS) {
  //      if (mines.get(i).isClicked() == false)

  //        return true;
  //    }
  //  }



  for (int i = 0; i < mines.size(); i++) {
    if (mines.get(i).flagged == false) {


      return false;
    } //end of if 

    else {


      return true;
    }

    //if you flagged everything
    //or if you clicked everything
  }
  return false;
}
public void displayLosingMessage()
{
  //your code here

  buttons[8][9].setLabel("Y");

  buttons[8][10].setLabel("O");

  buttons[8][11].setLabel("U");

  buttons[10][8].setLabel("L");

  buttons[10][9].setLabel("O");

  buttons[10][10].setLabel("S");

  buttons[10][11].setLabel("E");

  buttons[10][12].setLabel("!");
}
public void displayWinningMessage()
{
  //if(isWon() == true){

  //  System.out.println("you won");

  //}

  buttons[8][9].setLabel("Y");

  buttons[8][10].setLabel("O");

  buttons[8][11].setLabel("U");

  buttons[9][9].setLabel("W");

  buttons[9][10].setLabel("I");

  buttons[9][11].setLabel("N");

  buttons[10][9].setLabel("!");

  buttons[10][10].setLabel("!");

  buttons[10][11].setLabel("!");
  
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
    
    //fill(buttons[r][c], )
    
    
    }
  
  }
  
}
public boolean isValid(int r, int c)
{
  if (r >= 0 && r < NUM_ROWS && c >+ 0 && c < NUM_COLS) {

    return true;
  }
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  //your code here

  if (isValid(row - 1, col - 1) && mines.contains(buttons[row - 1][col - 1])) {

    numMines ++;
  } 
  if (isValid(row - 1, col) && mines.contains(buttons[row - 1][col])) {

    numMines ++;
  } 
  if (isValid(row - 1, col + 1) && mines.contains(buttons[row - 1][col + 1])) {

    numMines ++;
  } 
  if (isValid(row, col - 1) && mines.contains(buttons[row][col - 1])) {

    numMines ++;
  } 
  if (isValid(row, col + 1) && mines.contains(buttons[row][col + 1])) {

    numMines ++;
  } 
  if (isValid(row + 1, col - 1) && mines.contains(buttons[row + 1][col - 1])) {

    numMines ++;
  } 
  if (isValid(row + 1, col) && mines.contains(buttons[row + 1][col])) {

    numMines ++;
  } 
  if (isValid(row + 1, col + 1) && mines.contains(buttons[row + 1][col + 1])) {

    numMines ++;
  }

  return numMines;
}

public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  public boolean isClicked() {

    return clicked;
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    //your code here


    if (mouseButton == RIGHT) {

      flagged = !flagged; 

      if (flagged == false) {

        clicked = false;
      } // end of inner if
    } else if (isValid(myRow, myCol) && mines.contains(buttons[myRow][myCol])) {

      displayLosingMessage();
    } else if (countMines(myRow, myCol) > 0) {

      setLabel(countMines(myRow, myCol));
    } else {

      //else recursively call mousePressed with the valid, unclicked, neighboring buttons in all 8 directions


      if (isValid(myRow - 1, myCol - 1) && buttons[myRow - 1][myCol-1].isClicked() == false) {
        buttons[myRow-1][myCol-1].mousePressed();
      } // up left

      if (isValid(myRow - 1, myCol) && buttons[myRow - 1][myCol].isClicked() == false) {
        buttons[myRow-1][myCol].mousePressed();
      } //up above

      if (isValid(myRow - 1, myCol + 1) && buttons[myRow - 1][myCol + 1].isClicked() == false) {
        buttons[myRow-1][myCol+1].mousePressed();
      } //up right

      if (isValid(myRow, myCol - 1) && buttons[myRow][myCol - 1].isClicked() == false) {
        buttons[myRow][myCol-1].mousePressed();
      } //same left

      if (isValid(myRow, myCol + 1) && buttons[myRow][myCol + 1].isClicked() == false) {
        buttons[myRow][myCol+1].mousePressed();
      } //same right

      if (isValid(myRow + 1, myCol - 1) && buttons[myRow + 1][myCol-1].isClicked() == false) {
        buttons[myRow+1][myCol-1].mousePressed();
      } // up left

      if (isValid(myRow + 1, myCol) && buttons[myRow + 1][myCol].isClicked() == false) {
        buttons[myRow+1][myCol].mousePressed();
      } //up above

      if (isValid(myRow + 1, myCol + 1) && buttons[myRow + 1][myCol + 1].isClicked() == false) {
        buttons[myRow+1][myCol+1].mousePressed();
      } //up right
    }
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    //else if(isWon() == true){
    //fill((int)(Math.random()* 255)); 
    
    //}
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }

  //System.out.println(countMines(10, 10));
}
