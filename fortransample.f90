subroutine foo()
implicit none
    integer :: c=0

    c = c+1
    print*, c
end subroutine

program main
implicit none
    integer :: i

    do i = 1, 5
        call foo()
    end do
end program
