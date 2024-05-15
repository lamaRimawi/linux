#!/bin/bash
player1=""
player2=""
player1_score=0
player2_score=0
move_count=0
echo "Welcome to the XO game!"
echo "-----------------------"

#Players' Names
# Prompt players for their names
echo "Player 1, please enter your name:"
read player1
echo "Player 2, please enter your name:"
read player2

# Display players' names
echo "Player 1: $player1 (X)"
echo "Player 2: $player2 (O)"
#set game configration
echo "How many moves should the game last?"
read max_moves
echo "Specify the dimentions of the grid (3,4,or 5):"
read N
if [[ $N -eq 3 || $N -eq 4 || $N -eq 5 ]]
then
echo "valid size"
else
echo "Invalid grid size.Please choose 3,4,or 5."
exit 1
fi

#Initialize a grid with 2D array
declare -a grid
for ((i=0;i<N*N;i++))
do 
grid[i]=' ' 
done


#Option to load from file
while true
 do
    echo "Do you want to start a new game or load from a file? (new/load)"
    read choice
    if [ "$choice" == "new" ]
          then
        break
    elif [ "$choice" == "load" ]
 then
        echo "Enter the file name:"
        read filename
        if [ -f "$filename" ]
 then
            # Load game from file
            echo "Loading game from file..."
i=0
while IFS='|' read -ra cells
do 
for cell in "${cells[@]}"
do
grid[i]="$cell"
i=$((i+1))
done
done < "$filename"

            break
        else
            echo "File not found. Please enter a valid file name."
        fi
    else
        echo "Invalid option. Please choose 'new' or 'load'."
         fi
done

#--------------------------------
#display the initial grid
display_grid() {
for (( i=0;i<N*N;i++))
do
if [ $((i%N)) -eq $((N-1)) ]
then
echo -n "${grid[i]} "
echo
else
echo -n "${grid[i]} |"
fi
done
}
#-----------------------------------
print_menu() {
local player=$1
local mark=$2
local opponent_mark 
if [ "$mark" == "x" ]
then
opponent_mark="o"
else
opponent_mark="x"
fi
local choice
echo "It's a $player's turn ($mark)."
echo "choose your move:"
echo "1. place a mark "
echo "2.remove a mark ($mark)"
echo "3.Exchange rows"
echo "4.Exchange columns"
echo "5.Exchange marks"
echo "6.Quit the game"
echo "Enter your choice (1-6): " 
 read choice
case $choice in 
1) place_mark "$player" "$mark" ;;
 2) remove_mark "$player" "$mark"  ;; 
3) exchange_rows "$player"  ;;
4) exchange_columns "$player"   ;;
5) exchange_marks "$player" "$mark" "$opponent_mark"  ;;
6) echo "Exiting the game." 
     return 1 ;;
*) echo "Invalid option.Please try again." ;;
esac
update_scores "$mark" "$opponent_mark" 
#Display the updated scores
echo "current scores:"
echo "$player1: $player1_score"
echo "$player2: $player2_score"

return 0
}

#--------------------------------------------
place_mark() {
local player=$1
local mark=$2
local row col index
#prompt the player for coordinate
echo "$player, enter the row and column numbers to place your $mark:"
read row col
#asjust for zero based indexing
row=$((row-1))
col=$((col-1))
#claculate the index for grid
index=$((row * N + col))
#validate the coordinates and check if the cell is empty
if [ "$row" -ge 0 ] && [ "$row" -lt "$N" ] && [ "$col" -ge 0 ] && [ "$col" -lt "$N" ] && [ "${grid[index]}" == " " ]
then
grid[index]=$mark
display_grid
else
echo "Invalid move or cell is already occupied. please try again."
place_mark "$player" "$mark"
fi 

}
#-----------------------------------
remove_mark() {
local player=$1
local mark=$2
local row col index

#prompt the player for coordinate
echo "$player, enter the row and column numbers of the mark you want to remove:"
read row col
#adjust for zero based indexing 
row=$((row-1))
col=$((col-1))
#calc for index in  grid
index=$((row * N +col))
#validate the coordinates and check if cell contains content the players mark
if [ "$row" -ge 0 ] && [ "$row" -lt $N ] && [ "$col" -ge 0 ] && [ "$col" -lt $N ] && [ "${grid[index]}" == "$mark" ]
then
grid[index]=' ' 
display_grid
#update the player's score
if [ $mark = "x" ]
then
player1_score=$(( player1_score + 1 ))
echo "Score updated: $player has $player1_score points."

else
player2_score=$(( player2_score + 1 ))
echo "Score updated: $player has $player2_score points."

fi


else
echo "Invalid move or cell does not contain your mark. please try again."
remove_mark "$player" "$mark"
fi


}
#----------------------------------------
exchange_rows() {
local player=$1
local row1 row2 temp  i
#prompt the player for the row numbers
echo "$player,enter the numbers of the two rows you want to exchange:"
read row1 row2
#adjust for zero based indexing 
row1=$((row1 -1))
row2=$((row2 -1))
#validate the row numbers
if [ "$row1" -ge 0 ] && [ "$row1" -lt "$N" ] && [ "$row2" -ge 0 ] && [ "$row2" -lt "$N" ] && [ "$row1" -ne "$row2" ] 
then
#exchange 2 rows
for ((i=0;i<N;i++))
do
temp="${grid[$((row1 *N + i))]}"
  grid[$((row1 * N + i ))]="${grid[$((row2 *N + i))]}"
grid[$((row2 * N + i ))]=$temp
done
display_grid
if [ $mark = "x" ]
then
player1_score=$(( player1_score - 1 ))
echo "Score updated: $player has $player1_score points."

else
player2_score=$(( player2_score - 1 ))
echo "Score updated: $player has $player2_score points."

fi

else
echo "Invalid row numbers or rows are the same.Please try again."
exchange_rows "$player" 
fi
}
#-------------------------------------
exchange_columns() {
local player=$1
local col1 col2 temp i
#prompt the player for the col numbers
echo "$player,enter the numbers of the two columns you want to exchange:"
read col1 col2
#adjust for zero based indexing 
col1=$((col1 -1))
col2=$((col2 -1))
#validate the row numbers
if [ "$col1" -ge 0 ] && [ "$col1" -lt "$N" ] && [ "$col2" -ge 0 ] && [ "$col2" -lt "$N" ] && [ "$col1" -ne "$col2" ] 
then
#exchange 2 columns
for ((i=0;i<N;i++))
do
temp="${grid[$((col1 *N + i))]}"
  grid[$((col1 * N + i ))]="${grid[$((col2 *N + i))]}"
grid[$((col2 * N + i ))]=$temp
done
display_grid
if [ $mark = "x" ]
then
player1_score=$(( player1_score - 1 ))
echo "Score updated: $player has $player1_score points."

else
player2_score=$(( player2_score - 1 ))
echo "Score updated: $player has $player2_score points."

fi


else
echo "Invalid column numbers or columns are the same.Please try again."

exchange_columns "$player"
fi
}
#---------------------------------
exchange_marks() {
    local player=$1
    local player_mark=$2
    local opponent_mark=$3
    local player_row player_col opponent_row opponent_col player_index opponent_index

    # Prompt the player for the coordinate of their mark and opponent mark
    echo "$player, enter the row and column numbers of your mark to exchange:"
    read player_row player_col
    echo "$player, enter the row and column numbers of opponent mark to exchange:"
     read opponent_row opponent_col


    # Adjust for zero-based indexing
    player_row=$((player_row - 1))
    player_col=$((player_col - 1))
    opponent_row=$((opponent_row - 1))
    opponent_col=$((opponent_col - 1))

    # Calculate the indexes for the grid array
    player_index=$((player_row * N + player_col))
    opponent_index=$((opponent_row * N + opponent_col)) 

 # Validate the coordinates and check if the cells contain the correct marks
if [ "$player_row" -ge 0 ] && [ "$player_row" -lt "$N" ] && [ "$player_col" -ge 0 ] && [ "$player_col" -lt "$N" ] && [ "$opponent_row" -ge 0 ] && [ "$opponent_row" -lt "$N" ] && [ "$opponent_col" -ge 0 ] && [ "$opponent_col" -lt "$N" ] && [ "${grid[player_index]}" = "$player_mark" ] && [ "${grid[opponent_index]}" = "$opponent_mark" ]
    
then
        # Perform the exchange
        temp=${grid[player_index]}
        grid[player_index]=${grid[opponent_index]}
        grid[opponent_index]="$temp"

        # Display the updated grid
        display_grid

        # Update the scores (assuming $mark should be $player_mark)
        if [ "$player_mark" = "x" ]
          then
            player1_score=$((player1_score - 2))
            echo "Score updated: $player has $player1_score points."
        else
            player2_score=$((player2_score - 2))
            echo "Score updated: $player has $player2_score points."
        fi
    else

        echo "Invalid coordinates or incorrect marks. Please try again."

        exchange_marks "$player" "$player_mark" "$opponent_mark"
    fi 
}

#---------------------------------
check_alignments() {
local mark=$1
local alignments=0
#check horizontal alignments
for ((row=0;row<N;row++))
do
local count=0
for ((col=0;col<N;col++))
do
if [ "${grid[$((row * N + col))]}" == "$mark" ]
then
count=$((count +1 ))
fi
done
if [ "$count" -eq "$N" ] 
then
alignments=$((alignments +1))
fi
done
#check vertical alignments
for ((col=0;col<N;col++))
do
local count=0
for ((row=0;row<N;row++))
do
if [ "${grid[$((row * N + col))]}" == "$mark" ]
then
count=$((count +1 ))
fi
done
if [ "$count" -eq "$N" ] 
then
alignments=$((alignments +1))
fi
done
#check diagonal alignment
local count_diag1=0
local count_diag2=0
for ((i=0;i<N;i++))
do
if [ "${grid[$((i * N +i))]}" == "$mark" ] 
then
count_diag1=$((count_diag1 +1 ))
fi
if [ "${grid[$(((N -i -1)*N +i))]}" == "$mark" ] 
then
count_diag2=$((count_diag2 +1 ))
fi
done
if [ "$count_diag1" -eq "$N" ]
then
alignments=$((alignments +1))
fi
if [ "$count_diag2" -eq "$N" ]
then
alignments=$((alignments +1))
fi
return $alignments
}
#-------------------------------------
update_scores() {
local player_mark=$1
local opponent_mark=$2
#check alignment for player's mark
check_alignments "$player_mark"
local player_alignments=$?
if [ $player_mark = "x" ]
then
player1_score=$(( player1_score + player_alignments * 2 ))
else
player2_score=$((player2_score + player_alignments * 2 ))
fi
#check alignment for opponent's mark
check_alignments "$opponent_mark"
local opponent_alignments=$?
if [ $opponent_mark = "x" ]
then
player1_score=$(( player1_score - opponent_alignments * 3 ))
else
player2_score=$((player2_score - opponent_alignments * 3 ))
fi

}
#---------------------------------------------------------
check_for_win() {
    local mark=$1
    if ! check_alignments "$mark"
    then
        echo "Win detected for $mark"
        return 0   # win detected
    else
        echo "No win for $mark"
        return 1   # no win
    fi
}

#---------------------------------------------------
display_grid
# Main game loop with options
while true 
do 
    # Player 1 turn
    echo "It's $player1 's turn x."
    if ! print_menu "$player1" "x"
    then
        break  # Exit the loop if player chooses to quit
    fi
    move_count=$((move_count+1)) 
    if  check_for_win "x" 
    then
        echo "$player1 wins!"
        break
    elif [ "$move_count" -ge "$max_moves" ] 
    then
        echo "The game is a draw."
        break
    fi
    
    # Player 2 turn
    echo "It's $player2 's turn o."
    if ! print_menu "$player2" "o"
    then
        break
    fi
    move_count=$((move_count+1))
    if  check_for_win "o" 
    then
        echo "$player2 wins!"
        break
    elif [ "$move_count" -ge "$max_moves" ] 
    then
        echo "The game is a draw."
        break
    fi
done

#---------------------------------------
#Display final message
echo "Game over.Final scores:"
echo "$player1: $player1_score"
echo "$player2: $player2_score"


